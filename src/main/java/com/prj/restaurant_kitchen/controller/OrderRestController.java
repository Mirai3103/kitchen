package com.prj.restaurant_kitchen.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpStatusCodeException;

import com.prj.restaurant_kitchen.entities.ChiTietBan;
import com.prj.restaurant_kitchen.entities.MenuItem;
import com.prj.restaurant_kitchen.entities.Notification;
import com.prj.restaurant_kitchen.entities.RecipeDetail;
import com.prj.restaurant_kitchen.repository.MenuItemRepository;
import com.prj.restaurant_kitchen.repository.NotificationRepository;
import com.prj.restaurant_kitchen.repository.RecipeDetailRepository;
import com.prj.restaurant_kitchen.utils.ErrorException;

import jakarta.transaction.Transactional;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.prj.restaurant_kitchen.repository.BanRepository;
import com.prj.restaurant_kitchen.repository.ChiTietBanRepository;
import com.prj.restaurant_kitchen.repository.MaterialBatchRepository;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/api/order")
@AllArgsConstructor
public class OrderRestController {
    private final MenuItemRepository menuItemRepository;
    private final ChiTietBanRepository chiTietBanRepository;
    private final BanRepository banRepository;
    private final NotificationRepository notificationRepository;
    private final RecipeDetailRepository recipeDetailRepository;
    private final MaterialBatchRepository materialBatchRepository;

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
        notification.setTableId(orderRequest.tableId);
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
    @Transactional(rollbackOn = ErrorException.class)
    public Map<String, Object> startCooking(@PathVariable int id) {
        // todo: tru nguyen lieu
        var chiTietBan = chiTietBanRepository.findById(id);
        var recipeDetailList = recipeDetailRepository.findByMenuItemId(chiTietBan.get().getIdMon());
        var materialIdNeedMap = recipeDetailList.stream()
                .collect(Collectors.toMap(RecipeDetail::getMaterialId, RecipeDetail::getQuantity));

        var materialBatchList = materialBatchRepository
                .findByMaterialIdInAndExpiredDateGreaterThanOrderByExpiredDateAsc(materialIdNeedMap.keySet(),
                        java.time.LocalDateTime.now());
        for (var materialBatch : materialBatchList) {
            var materialId = materialBatch.getMaterialId();
            var quantityNeed = materialIdNeedMap.get(materialId);
            // nếu nguyên liệu trừ đủ r thì bỏ qua
            if (quantityNeed == null) {
                continue;
            }
            // nếu lô dư nguyên liệu lớn hơn hoặc bằng số lượng cần thì trừ nguyên liệu và
            // bỏ qua
            if (materialBatch.getQuantity() >= quantityNeed) {
                materialBatch.setQuantity(materialBatch.getQuantity() - quantityNeed);
                materialBatchRepository.save(materialBatch);
                materialIdNeedMap.remove(materialId);
            } else {
                // nếu lô dư nguyên liệu nhỏ hơn số lượng cần thì trừ hết lô dư và cập nhật số
                // lượng cần
                quantityNeed -= materialBatch.getQuantity();
                materialBatch.setQuantity(0);
                materialBatchRepository.save(materialBatch);
                materialIdNeedMap.put(materialId, quantityNeed);
            }
            if (materialIdNeedMap.isEmpty()) {
                break;
            }
        }
        // nếu còn nguyên liệu cần thì trả về lỗi
        if (!materialIdNeedMap.isEmpty()) {
            throw new ErrorException(400, "Không đủ nguyên liệu");
        }

        chiTietBan.ifPresent(ctb -> {
            ctb.setStatus("Đang nấu");
            chiTietBanRepository.save(ctb);
        });
        Notification notification = new Notification();
        notification.setTableId(chiTietBan.get().getIdBan());
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
        notification.setTableId(chiTietBan.get().getIdBan());
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
        notification.setTableId(chiTietBan.get().getIdBan());
        notification.setMessage(String.format("Món %s đã được phục vụ", chiTietBan.get().getMon().getTenMon()));
        notification.setRead(false);
        notification.setNavigationLink("");
        notificationRepository.save(notification);
        return Map.of("status", true);
    }

    @GetMapping("kitchen")
    public List<ChiTietBan> getAllOrderItem() {
        var chiTietBanList = chiTietBanRepository.findAllByStatusNotInOrderByIdDesc(List.of("Hoàn thành"));

        Set<Integer> pendingCategoryIds = chiTietBanList.stream()
                .filter(record -> "Đang nấu".equals(record.getStatus()))
                .map(record -> record.getIdMon())
                .collect(Collectors.toSet());
        chiTietBanList.sort((r1, r2) -> {
            // Ưu tiên theo status
            if ("Đang nấu".equals(r1.getStatus()) && !"Đang nấu".equals(r2.getStatus())) {
                return -1;
            }
            if (!"Đang nấu".equals(r1.getStatus()) && "Đang nấu".equals(r2.getStatus())) {
                return 1;
            }

            // Ưu tiên theo categoryId nếu cùng với PENDING
            if (pendingCategoryIds.contains(r1.getIdMon()) && !pendingCategoryIds.contains(r2.getIdMon())) {
                return -1;
            }
            if (!pendingCategoryIds.contains(r1.getIdMon()) && pendingCategoryIds.contains(r2.getIdMon())) {
                return 1;
            }

            // Sắp xếp theo thời gian
            return r1.getCreatedAt().compareTo(r2.getCreatedAt());
        });
        return chiTietBanList;
    }

}
