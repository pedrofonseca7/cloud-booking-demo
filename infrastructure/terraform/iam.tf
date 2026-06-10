resource "aws_iam_role" "ec2_sqs_role" {
  name = "cloud-booking-ec2-sqs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "ec2_sqs_policy" {
  name = "cloud-booking-ec2-sqs-policy"
  role = aws_iam_role.ec2_sqs_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ]
      Resource = [
        aws_sqs_queue.booking_notifications.arn,
        aws_sqs_queue.booking_dlq.arn
      ]
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "cloud-booking-ec2-profile"
  role = aws_iam_role.ec2_sqs_role.name
}