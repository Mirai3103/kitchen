package com.prj.restaurant_kitchen.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Ban {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private int idPhong;

    @Column(nullable = false, length = 100)
    private String tenBan;

    @Column(nullable = false, length = 50)
    private String status;

    @ManyToOne()
    @JoinColumn(name = "idPhong", insertable = false, updatable = false)
    private Phong phong;
}
