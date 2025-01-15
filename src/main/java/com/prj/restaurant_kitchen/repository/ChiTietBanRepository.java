package com.prj.restaurant_kitchen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.ChiTietBan;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface ChiTietBanRepository extends JpaRepository<ChiTietBan, Integer> {
    public List<ChiTietBan> findByIdBan(int banId);

    List<ChiTietBan> findAllByStatusInOrderByIdDesc(List<String> status);

    @Transactional
    void deleteByBan_Id(int banId);
    List<ChiTietBan> findAllByStatusNotInOrderByIdDesc(List<String> status);
}
