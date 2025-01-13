package com.prj.restaurant_kitchen.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.prj.restaurant_kitchen.entities.ChiTietBan;
import com.prj.restaurant_kitchen.entities.MenuItem;
import com.prj.restaurant_kitchen.entities.Notification;
import com.prj.restaurant_kitchen.repository.MenuItemRepository;
import com.prj.restaurant_kitchen.repository.NotificationRepository;

import java.util.Map;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.prj.restaurant_kitchen.repository.BanRepository;
import com.prj.restaurant_kitchen.repository.ChiTietBanRepository;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PutMapping;

@RestController
@RequestMapping("/api/order")
@AllArgsConstructor
public class OrderRestController {
    private final MenuItemRepository menuItemRepository;
    private final ChiTietBanRepository chiTietBanRepository;
    private final BanRepository banRepository;
    private final NotificationRepository notificationRepository;

    public static class OrderRequest {
        public int tableId;
        public int roomId;
        public int menuItemId;
        public int quantity;
    }

    @PostMapping()
    public Map<String, Object> order(@RequestBody OrderRequest orderRequest) {
        System.out.println(orderRequest.tableId);
        System.out.println(orderRequest.roomId);
        System.out.println(orderRequest.menuItemId);
        System.out.println(orderRequest.quantity);
        var menuItemOp = menuItemRepository.findById(orderRequest.menuItemId);
        var ban = banRepository.findById(orderRequest.tableId);
        ban.ifPresent(b -> {
            b.setStatus("Đã đặt món");
            banRepository.save(b);
        });
        ChiTietBan chiTietBan = new ChiTietBan();
        chiTietBan.setSoLuong(orderRequest.quantity);
        chiTietBan.setIdBan(orderRequest.tableId);
        chiTietBan.setIdPhong(orderRequest.roomId);
        chiTietBan.setIdMon(orderRequest.menuItemId);
        chiTietBan.setDonGia(menuItemOp.get().getGia());
        chiTietBanRepository.save(chiTietBan);
        Notification notification = new Notification();
        notification.setMessage(
                String.format(" %s - %s đã đặt x%d %s", ban.get().getTenBan(), ban.get().getPhong().getTenPhong(),
                        orderRequest.quantity, menuItemOp.get().getTenMon()));
        notification.setRead(false);
        notification.setNavigationLink("/kitchen-manager");
        notificationRepository.save(notification);
        return Map.of("status", true);
    }

    @DeleteMapping("/{id}")
    public Map<String, Object> deleteOrder(@PathVariable int id) {
        chiTietBanRepository.deleteById(id);
        return Map.of("status", true);
    }

    @PutMapping("start-cooking/{id}")
    public Map<String, Object> startCooking(@PathVariable int id) {
        var chiTietBan = chiTietBanRepository.findById(id);
        chiTietBan.ifPresent(ctb -> {
            ctb.setStatus("Đang nấu");
            chiTietBanRepository.save(ctb);
        });
        Notification notification = new Notification();
        notification.setMessage(String.format("Món %s đang được nấu", chiTietBan.get().getMon().getTenMon()));
        notification.setRead(false);
        notification.setNavigationLink("/kitchen-manager");
        notificationRepository.save(notification);
        return Map.of("status", true);
    }

    @PutMapping("finish-cooking/{id}")
    public Map<String, Object> finishCooking(@PathVariable int id) {
        var chiTietBan = chiTietBanRepository.findById(id);
        chiTietBan.ifPresent(ctb -> {
            ctb.setStatus("Đợi phục vụ");
            chiTietBanRepository.save(ctb);
        });
        Notification notification = new Notification();
        notification.setMessage(String.format("Món %s đã nấu xong", chiTietBan.get().getMon().getTenMon()));
        notification.setRead(false);
        notification.setNavigationLink("/kitchen-manager");
        notificationRepository.save(notification);
        return Map.of("status", true);
    }

    @PutMapping("served/{id}")
    public Map<String, Object> served(@PathVariable int id) {
        var chiTietBan = chiTietBanRepository.findById(id);
        chiTietBan.ifPresent(ctb -> {
            ctb.setStatus("Hoàn thành");
            chiTietBanRepository.save(ctb);
        });
        Notification notification = new Notification();
        notification.setMessage(String.format("Món %s đã được phục vụ", chiTietBan.get().getMon().getTenMon()));
        notification.setRead(false);
        notification.setNavigationLink("/kitchen-manager");
        notificationRepository.save(notification);
        return Map.of("status", true);
    }
}
