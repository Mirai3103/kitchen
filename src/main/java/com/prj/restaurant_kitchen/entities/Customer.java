package com.prj.restaurant_kitchen.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false, length = 100)
    private String hoTen;

    @Column(nullable = false, length = 15)
    private String phone;

    @Column(nullable = false, length = 255)
    private String diaChi;

    @Column(nullable = false, length = 100)
    private String tinh;

    @Column(nullable = false, length = 100)
    private String huyen;

    @Column(nullable = false, length = 100)
    private String xa;
}
