package com.prj.restaurant_kitchen.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookParty {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, length = 100)
    private String ten;

    @Column(nullable = false, length = 50)
    private String loai;

    @Column(nullable = true)
    private String hinhAnh;

    @Column(nullable = false)
    private int soLuong;
}
