package com.prj.restaurant_kitchen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.prj.restaurant_kitchen.repository.BanRepository;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class ProductController {
    private final BanRepository banRepository;

    @GetMapping("/")
    public String index(Model model) {
        banRepository.findAll().forEach(ban -> System.out.println(ban));
        return "index";
    }

}
