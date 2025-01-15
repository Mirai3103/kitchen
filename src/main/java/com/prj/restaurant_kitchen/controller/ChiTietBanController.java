package com.prj.restaurant_kitchen.controller;

import com.prj.restaurant_kitchen.repository.ChiTietBanRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/chitietban")
public class ChiTietBanController {

    private final ChiTietBanRepository chiTietBanRepository;

    public ChiTietBanController(ChiTietBanRepository chiTietBanRepository) {
        this.chiTietBanRepository = chiTietBanRepository;
    }

    @Transactional
    @DeleteMapping("/byban/{banId}")
    public ResponseEntity<?> deleteByBanId(@PathVariable int banId) {
        chiTietBanRepository.deleteByBan_Id(banId);
        return ResponseEntity.ok(Map.of(
                "status", true,
                "message", "Danh sách món đã được xóa cho bàn có ID " + banId
        ));
    }
}
