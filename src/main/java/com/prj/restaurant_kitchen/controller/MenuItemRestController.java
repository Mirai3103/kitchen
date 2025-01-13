package com.prj.restaurant_kitchen.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.prj.restaurant_kitchen.entities.RecipeDetail;
import com.prj.restaurant_kitchen.repository.MenuItemRepository;
import com.prj.restaurant_kitchen.repository.RecipeDetailRepository;

import lombok.AllArgsConstructor;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/api/menuItem")
@AllArgsConstructor
public class MenuItemRestController {
    private final MenuItemRepository menuItemRepository;
    private final RecipeDetailRepository recipeDetailRepository;

    @GetMapping("{id}/recipe")
    public List<RecipeDetail> getRecipe(@PathVariable int id) {
        var a=  recipeDetailRepository.findByMenuItemId(id);
        for (RecipeDetail recipeDetail : a) {
           recipeDetail.getMaterial().setMaterialBatches(null);
           recipeDetail.setMenuItem(null);
           
           
        }
        return a;
    }

}
