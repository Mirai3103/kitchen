package com.prj.restaurant_kitchen.controller;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.management.Notification;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import com.prj.restaurant_kitchen.entities.Ban;
import com.prj.restaurant_kitchen.repository.BanRepository;
import com.prj.restaurant_kitchen.repository.ChiTietBanRepository;
import com.prj.restaurant_kitchen.repository.MenuItemRepository;

import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;


@Controller
@AllArgsConstructor
public class HomePageController {
    private final BanRepository banRepository;
    private final ChiTietBanRepository chiTietBanRepository;
    private final MenuItemRepository menuItemRepository;

    // Ánh xạ yêu cầu GET tới URL "/home"
    @GetMapping("/home")
    public ModelAndView homePage(HttpSession session) {
        System.out.println(session.getAttribute("userLogin"));

        // Tạo ModelAndView và chuyển hướng tới trang JSP
        ModelAndView modelAndView = new ModelAndView("home-page");
        return modelAndView;
    }

    @GetMapping("order-table")
    public ModelAndView orderTable(ModelAndView modelAndView) {
        var banList = banRepository.findAll();
        System.out.println(banList.size());
        modelAndView.addObject("listBan", banList);
        modelAndView.setViewName("order-table");
        return modelAndView;

    }

    @GetMapping("datmon/{id}")
    public ModelAndView datMon(@PathVariable("id") int id, ModelAndView modelAndView) {
        modelAndView.addObject("id", id);
        modelAndView.setViewName("datmon");

        var banOp = banRepository.findById(id);
        if (banOp.isEmpty()) {
            return modelAndView;
        }
        Ban ban = banOp.get();
        modelAndView.addObject("ban", ban);
        var chiTietBan = chiTietBanRepository.findByIdBan(id);
        modelAndView.addObject("listChiTietBan", chiTietBan);
        var menuItems = menuItemRepository.findAll();
        modelAndView.addObject("menuItems", menuItems);
        return modelAndView;
    }

    @GetMapping("kitchen-manager")
    public ModelAndView kitchenOrder(ModelAndView modelAndView) {
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

        modelAndView.addObject("listChiTietBan", chiTietBanList);
        modelAndView.setViewName("kitchen-manager");
        return modelAndView;
    }

}