package com.cloudbooking.booking_api;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Booking {

    @Id
    private Long id;

    private String clientName;
    private String eventName;

    public Booking() {
    }

    public Booking(Long id, String clientName, String eventName) {
        this.id = id;
        this.clientName = clientName;
        this.eventName = eventName;
    }

    public Long getId() {
        return id;
    }

    public String getClientName() {
        return clientName;
    }

    public String getEventName() {
        return eventName;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }
}