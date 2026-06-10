package com.cloudbooking.booking_api;

import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.SendMessageRequest;

@Service
public class SqsService {

    private final SqsClient sqsClient;

    private static final String QUEUE_URL =
            "https://sqs.eu-west-1.amazonaws.com/265915575199/cloud-booking-notifications";

    public SqsService(SqsClient sqsClient) {
        this.sqsClient = sqsClient;
    }

    public void sendMessage(String message) {

        SendMessageRequest request = SendMessageRequest.builder()
                .queueUrl(QUEUE_URL)
                .messageBody(message)
                .build();

        sqsClient.sendMessage(request);
    }
}