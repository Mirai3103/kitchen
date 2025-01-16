package com.prj.restaurant_kitchen.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.prj.restaurant_kitchen.entities.Ban;
import com.prj.restaurant_kitchen.repository.BanRepository;

import lombok.AllArgsConstructor;

import java.util.Collection;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/api/ban")
@AllArgsConstructor
public class BanRestController {
    private final BanRepository banRepository;

    @GetMapping("")
    public Collection<Ban> getAllBan() {
        return banRepository.findAll();
    }

}
