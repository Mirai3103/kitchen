package com.prj.restaurant_kitchen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.Ban;
import com.prj.restaurant_kitchen.entities.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    // List<Order> orders = orderRepository.findByBan(ban);
}