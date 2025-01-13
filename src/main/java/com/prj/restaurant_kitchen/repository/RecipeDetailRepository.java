package com.prj.restaurant_kitchen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.RecipeDetail;

@Repository
public interface RecipeDetailRepository extends JpaRepository<RecipeDetail, Integer> {
    List<RecipeDetail> findByMenuItemId(int menuItemId);
}
