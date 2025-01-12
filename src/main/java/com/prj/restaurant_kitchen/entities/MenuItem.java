package com.prj.restaurant_kitchen.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "menu")
public class MenuItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, length = 100)
    private String tenMon;

    @Column(nullable = false)
    private double gia;

    @Column(length = 255)
    private String moTa;

    @Column(length = 255)
    private String nguyenLieu;

    @Column(length = 255)
    private String hinhAnh;

    @Column(length = 50)
    private String category;
}
