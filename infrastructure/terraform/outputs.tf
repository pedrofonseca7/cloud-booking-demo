output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "rds_port" {
  value = aws_db_instance.postgres.port
}

output "ec2_public_ip" {
  value = aws_instance.app.public_ip
}