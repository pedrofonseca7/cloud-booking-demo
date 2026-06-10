package com.cloudbooking.notification_service;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class NotificationController {

    @GetMapping("/notify")
    public Map<String, String> notifyService() {
        return Map.of("message", "Notification service online");
    }
}