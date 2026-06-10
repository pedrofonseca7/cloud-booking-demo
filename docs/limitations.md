# Limitations

## Current Limitations

### Single Instance Deployment

The application currently runs on a single EC2 instance.

Impact:

- No high availability
- Single point of failure

### No Load Balancer

The project does not currently use an AWS Load Balancer.

Impact:

- Traffic cannot be distributed across multiple instances

### Limited Monitoring

CloudWatch monitoring was not implemented.

Impact:

- Reduced observability

### Manual Scaling

Scaling must be performed manually.

Impact:

- No automatic elasticity

## Future Improvements

### ECS or Kubernetes

Deploy services using:

- Amazon ECS
- Amazon EKS

### Auto Scaling

Implement:

- Auto Scaling Groups
- Automatic recovery

### Monitoring

Integrate:

- Amazon CloudWatch
- Application metrics
- Alerts

### Secrets Management

Use:

- AWS Secrets Manager
- Parameter Store

### Advanced Messaging

Extend the messaging layer with:

- Additional consumers
- Event processing workflows
- Retry strategies