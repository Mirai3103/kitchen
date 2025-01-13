package com.prj.restaurant_kitchen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import com.prj.restaurant_kitchen.entities.Ban;
import com.prj.restaurant_kitchen.entities.ChiTietBan;
import com.prj.restaurant_kitchen.repository.BanRepository;
import com.prj.restaurant_kitchen.repository.ChiTietBanRepository;
import com.prj.restaurant_kitchen.repository.MenuItemRepository;

import lombok.AllArgsConstructor;
import lombok.var;

import org.springframework.web.bind.annotation.RequestParam;

@Controller
@AllArgsConstructor
public class HomePageController {
    private final BanRepository banRepository;
    private final ChiTietBanRepository chiTietBanRepository;
    private final MenuItemRepository menuItemRepository;

    // Ánh xạ yêu cầu GET tới URL "/home"
    @GetMapping("/home")
    public ModelAndView homePage() {
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
        var chiTietBanList = chiTietBanRepository.findAll();
        modelAndView.addObject("listChiTietBan", chiTietBanList);
        modelAndView.setViewName("kitchen-manager");
        return modelAndView;
    }

}