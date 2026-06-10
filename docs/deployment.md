# Deployment

## Infrastructure Deployment

Infrastructure is provisioned using Terraform.

Commands:

```bash
terraform init
terraform plan
terraform apply
```

## Containerization

Docker is used to package the applications.

Booking API:

```bash
docker build -t zeni7k/booking-api:v1 .
```

Notification Service:

```bash
docker build -t zeni7k/notification-service:v1 .
```

## Docker Hub

Images are published to Docker Hub.

Examples:

```bash
docker push zeni7k/booking-api:v1
docker push zeni7k/notification-service:v1
```

## Configuration Management

Ansible is used for deployment automation.

Deploy Booking API:

```bash
ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy-booking-api.yml
```

Deploy Notification Service:

```bash
ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy-notification-service.yml
```

## Application URLs

Booking API:

```txt
http://EC2_PUBLIC_IP:8081
```

Swagger:

```txt
http://EC2_PUBLIC_IP:8081/swagger-ui.html
```

Notification Service:

```txt
http://EC2_PUBLIC_IP:8082/notify
```

## Database

Database engine:

- PostgreSQL

Hosted on:

- AWS RDS