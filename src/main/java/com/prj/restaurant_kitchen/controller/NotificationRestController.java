package com.prj.restaurant_kitchen.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.prj.restaurant_kitchen.entities.Notification;
import com.prj.restaurant_kitchen.repository.NotificationRepository;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/api/notification")
@AllArgsConstructor
public class NotificationRestController {
    private final NotificationRepository notificationRepository;

    @PutMapping("/markAsRead/{id}")
    public void markAsRead(@PathVariable int id) {
        notificationRepository.markAsRead(id);
    }

    @GetMapping("/table/{id}")
    public List<Notification> getMethodName(@PathVariable int id, Pageable pageable) {
        return notificationRepository.findAllByTableIdOrderByIdDesc(id, pageable);
    }

    @GetMapping("")
    public List<Notification> getAllNotifications(Pageable pageable) {
        return notificationRepository.findAllByOrderByIdDesc(pageable);
    }

    @DeleteMapping("/{id}")
    public void deleteNotification(@PathVariable int id) {
        notificationRepository.deleteById(id);
    }
}
