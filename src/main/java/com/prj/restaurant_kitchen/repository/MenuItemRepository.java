package com.prj.restaurant_kitchen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.MenuItem;

@Repository
public interface MenuItemRepository extends JpaRepository<MenuItem, Integer> {
    // List<MenuItem> menuItems = menuRepository.findByTenMonContaining(tenMon);
    List<MenuItem> findByTenMonContaining(String tenMon);
}
