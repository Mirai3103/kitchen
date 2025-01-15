package com.prj.restaurant_kitchen.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.ExclusionStrategy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.prj.restaurant_kitchen.repository.MaterialRepository;
import com.prj.restaurant_kitchen.utils.LocalDateTimeAdapter;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/material")
@AllArgsConstructor
public class MaterialController {
    private final MaterialRepository materialRepository;

    @GetMapping
    public ModelAndView showMaterialForm() {
        ModelAndView modelAndView = new ModelAndView("material");
        var materials = materialRepository.findAll();
        Gson gson = new GsonBuilder()
                // register custom JsonSerializer for LocalDate
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .setExclusionStrategies(new ExclusionStrategy[] { new ExclusionStrategy() {
                    @Override
                    public boolean shouldSkipField(com.google.gson.FieldAttributes f) {
                        return f.getName().equals("material");
                    }

                    @Override
                    public boolean shouldSkipClass(Class<?> clazz) {
                        return false;
                    }
                } })
                .create();
        modelAndView.addObject("materials", materials);
        modelAndView.addObject("materialsJson", gson.toJson(materials));
        modelAndView.setViewName("material");
        return modelAndView;
    }

}
