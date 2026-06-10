# Architecture

## Components

User
↓
Booking API
↓
RDS PostgreSQL

Booking API
↓
AWS SQS
↓
Notification Service

## Infrastructure

AWS VPC

Public Subnet:
- EC2

Private Components:
- RDS PostgreSQL

Messaging:
- SQS Queue
- Dead Letter Queue

## Communication

Synchronous:
- Booking API → Notification Service

Asynchronous:
- Booking API → SQS