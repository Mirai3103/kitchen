package com.prj.restaurant_kitchen.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.MaterialBatch;

import java.util.Collection;
import java.util.List;

@Repository
public interface MaterialBatchRepository extends JpaRepository<MaterialBatch, Integer> {
    List<MaterialBatch> findByMaterialIdInOrderByExpiredDateAsc(Collection<Integer> materialIds);

    List<MaterialBatch> findByMaterialIdInAndExpiredDateGreaterThanOrderByExpiredDateAsc(
            Collection<Integer> materialIds, java.time.LocalDateTime now);

}