# Cloud Booking Demo

Cloud-native booking system developed for the Cloud Information Systems course.

## Architecture

The system consists of:

- Booking API (Spring Boot)
- Notification Service (Spring Boot)
- AWS RDS PostgreSQL
- AWS SQS + DLQ
- EC2 Instance
- Docker Containers
- Terraform Infrastructure
- Ansible Deployment
- GitHub Actions CI/CD

## Features

- Create bookings
- Store bookings in PostgreSQL
- Send notification events through SQS
- Communication between microservices

## Technologies

- AWS
- EC2
- RDS PostgreSQL
- SQS
- Terraform
- Ansible
- Docker
- GitHub Actions
- Spring Boot

## Deployment

```bash
terraform apply
ansible-playbook deploy-booking-api.yml
```

## API Endpoints

Booking API:

- GET /bookings
- POST /bookings
- PUT /bookings/{id}
- DELETE /bookings/{id}

Notification Service:

- GET /notify

## Authors

Pedro Fonseca
