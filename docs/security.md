# Security

## IAM

The EC2 instance uses AWS IAM permissions to interact with AWS services.

Permissions granted:

- SQS SendMessage
- SQS ReceiveMessage
- SQS DeleteMessage

## Network Security

Security Groups restrict access to the application.

Allowed inbound traffic:

- SSH (22)
- Booking API (8081)
- Notification Service (8082)

## Database Security

Database access is restricted to the application infrastructure.

The database is hosted on AWS RDS.

## Secrets

Sensitive information is not hardcoded in the source code.

Examples:

- Database credentials
- AWS credentials

## Message Reliability

AWS SQS uses a Dead Letter Queue (DLQ).

Benefits:

- Failed messages are preserved
- Easier troubleshooting
- Increased reliability

## Container Security

Applications run inside Docker containers.

Benefits:

- Isolation
- Reproducibility
- Consistent deployments