package com.prj.restaurant_kitchen.repository;

import com.prj.restaurant_kitchen.entities.Ban;
import com.prj.restaurant_kitchen.entities.Phong;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BanRepository extends JpaRepository<Ban, Integer> {
    List<Ban> findByIdPhong(int idPhong);
}
