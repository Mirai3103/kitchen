package com.prj.restaurant_kitchen.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.MaterialBatch;

@Repository
public interface MaterialBatchRepository extends JpaRepository<MaterialBatch, Integer> {
    
    
}