package com.prj.restaurant_kitchen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.prj.restaurant_kitchen.repository.BanRepository;

import lombok.AllArgsConstructor;
import lombok.var;

import org.springframework.web.bind.annotation.RequestParam;

@Controller
@AllArgsConstructor
public class HomePageController {
    private final BanRepository banRepository;

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

}