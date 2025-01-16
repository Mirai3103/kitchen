package com.prj.restaurant_kitchen.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.Ban;
import com.prj.restaurant_kitchen.entities.ChiTietBan;

import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import org.springframework.transaction.annotation.Transactional;

@Repository
public interface ChiTietBanRepository extends JpaRepository<ChiTietBan, Integer> {
    public List<ChiTietBan> findByIdBan(int banId);

    List<ChiTietBan> findAllByStatusInOrderByIdDesc(List<String> status);

    @Transactional
    void deleteByBan_Id(int banId);

    List<ChiTietBan> findAllByStatusNotInOrderByIdDesc(List<String> status);

    Optional<ChiTietBan> findFirstByStatusAndIdMonAndIdBan(String status, int idMon, int idBan);
<<<<<<< HEAD
}
=======
}
>>>>>>> 4946b4c58a920590d5dcf092f05e0bf06d3265d1
