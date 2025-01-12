package com.prj.restaurant_kitchen.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.prj.restaurant_kitchen.entities.User;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    // Tìm kiếm người dùng theo tên đăng nhập và mật khẩu
    @Query("SELECT u FROM User u WHERE u.userName = :userName AND u.password = :password")
    Optional<User> loginUser(@Param("userName") String userName, @Param("password") String password);
}