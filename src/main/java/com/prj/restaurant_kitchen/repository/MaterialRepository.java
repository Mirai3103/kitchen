package com.prj.restaurant_kitchen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.Material;

@Repository
public interface MaterialRepository extends JpaRepository<Material, Integer> {
    @SuppressWarnings("null")
    @EntityGraph(attributePaths = { "materialBatches" })
    public List<Material> findAll();
}
