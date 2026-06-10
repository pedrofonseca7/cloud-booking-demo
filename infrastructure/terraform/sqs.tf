resource "aws_sqs_queue" "booking_dlq" {
  name = "cloud-booking-dlq"
}

resource "aws_sqs_queue" "booking_notifications" {
  name = "cloud-booking-notifications"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.booking_dlq.arn
    maxReceiveCount     = 3
  })
}

output "sqs_queue_url" {
  value = aws_sqs_queue.booking_notifications.url
}

output "sqs_dlq_url" {
  value = aws_sqs_queue.booking_dlq.url
}