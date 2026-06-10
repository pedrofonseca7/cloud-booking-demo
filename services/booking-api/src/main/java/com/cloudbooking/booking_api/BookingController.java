package com.cloudbooking.booking_api;

import org.springframework.web.bind.annotation.*;

import java.util.List;

import org.springframework.web.client.RestTemplate;

import java.util.Map;

@RestController
@RequestMapping("/bookings")
public class BookingController {

    private final BookingRepository bookingRepository;
    private final SqsService sqsService;
    private final RestTemplate restTemplate = new RestTemplate();

    public BookingController(BookingRepository bookingRepository, SqsService sqsService) {
        this.bookingRepository = bookingRepository;
        this.sqsService = sqsService;
    }

    @GetMapping
    public List<Booking> getBookings() {
        return bookingRepository.findAll();
    }

    @PostMapping
    public Map<String, Object> createBooking(@RequestBody Booking booking) {

        Booking saved = bookingRepository.save(booking);

        sqsService.sendMessage(
                "New booking created: " + saved.getClientName() + " - " + saved.getEventName()
        );

        String notificationResponse = restTemplate.getForObject(
                "http://52.209.110.168:8082/notify",
                String.class
        );

        return Map.of(
                "booking", saved,
                "notification", notificationResponse,
                "sqs", "Message sent to SQS"
        );
    }

    @DeleteMapping("/{id}")
    public void deleteBooking(@PathVariable Long id) {
        bookingRepository.deleteById(id);
    }

    @PutMapping("/{id}")
    public Booking updateBooking(@PathVariable Long id, @RequestBody Booking updatedBooking) {

        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setClientName(updatedBooking.getClientName());
        booking.setEventName(updatedBooking.getEventName());

        return bookingRepository.save(booking);
    }
}