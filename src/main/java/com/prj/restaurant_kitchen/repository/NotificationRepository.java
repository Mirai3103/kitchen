package com.prj.restaurant_kitchen.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.Notification;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Integer> {
    @Query("UPDATE Notification n SET n.isRead = true WHERE n.id = ?1")
    @Modifying
    void markAsRead(int id);

    List<Notification> findAllByOrderByIdDesc(Pageable pageable);
}
