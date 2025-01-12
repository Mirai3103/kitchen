package com.prj.restaurant_kitchen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.Phong;

@Repository
public interface PhongRepository extends JpaRepository<Phong, Integer> {
    // List<Phong> phongs = phongRepository.findByTenPhongContaining(tenPhong);
    List<Phong> findByTenPhongContaining(String tenPhong);

}
