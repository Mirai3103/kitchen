package com.prj.restaurant_kitchen.controller;

import com.prj.restaurant_kitchen.entities.Ban;
import com.prj.restaurant_kitchen.repository.BanRepository;
import com.prj.restaurant_kitchen.repository.NotificationRepository;

import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/ban")
@AllArgsConstructor
public class BanController {

    private final BanRepository banRepository;
    private final NotificationRepository notificationRepository;

    /**
     * Cập nhật trạng thái của bàn theo ID.
     * Ví dụ: PUT /api/ban/5/status?status=Trống
     */
    @PutMapping("/{id}/status")
    public ResponseEntity<?> updateStatus(@PathVariable int id, @RequestParam String status) {
        Optional<Ban> optionalBan = banRepository.findById(id);
        if (optionalBan.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Ban ban = optionalBan.get();
        ban.setStatus(status);
        banRepository.save(ban);
        return ResponseEntity.ok(Map.of("status", true, "message", "Trạng thái bàn đã được cập nhật"));
    }

    /**
     * Endpoint đặc biệt để đánh dấu bàn là đã phục vụ (tức chuyển trạng thái thành
     * "Trống").
     * Ví dụ: PUT /api/ban/{id}/served
     */
    @PutMapping("/{id}/served")
    @Transactional
    public ResponseEntity<?> markTableAsServed(@PathVariable int id) {
        Optional<Ban> optionalBan = banRepository.findById(id);
        if (optionalBan.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Ban ban = optionalBan.get();
        ban.setStatus("Trống"); // Đánh dấu bàn là đã phục vụ
        banRepository.save(ban);
        notificationRepository.deleteAllByTableId(id);
        return ResponseEntity.ok(Map.of("status", true, "message", "Bàn đã được đánh dấu là đã phục vụ và trống"));
    }
}
