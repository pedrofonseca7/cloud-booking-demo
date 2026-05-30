terraform {
  backend "s3" {
    bucket         = "cloud-booking-demo-tf-state-pedro-2026"
    key            = "envs/dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "cloud-booking-demo-tf-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "cloud-booking-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloud-booking-public-subnet"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "cloud-booking-private-subnet-b"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "cloud-booking-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "cloud-booking-public-rt"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web_sg" {
  name        = "cloud-booking-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-booking-web-sg"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "cloud-booking-key"
  public_key = file("${path.module}/../../cloud-booking-key.pub")
}

resource "aws_instance" "app" {
  ami                         = "ami-0c1c30571d2dae5c9"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "cloud-booking-app-ec2"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "cloud-booking-private-subnet"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "cloud-booking-db-sg"
  description = "Allow PostgreSQL from EC2 only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL from app EC2"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-booking-db-sg"
  }
}

resource "aws_db_subnet_group" "postgres" {
  name = "cloud-booking-db-subnet-group"

  subnet_ids = [
      aws_subnet.private.id,
      aws_subnet.private_b.id
  ]

  tags = {
    Name = "cloud-booking-db-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "cloud-booking-postgres"
  engine                 = "postgres"
  engine_version         = "16"
  instance_class         = "db.t3.micro"

  allocated_storage      = 20

  db_name                = "bookingdb"
  username               = "postgres"
  password               = "CloudBooking123!"

  publicly_accessible    = false

  skip_final_snapshot    = true

  vpc_security_group_ids = [
    aws_security_group.db_sg.id
  ]

  db_subnet_group_name = aws_db_subnet_group.postgres.name
}