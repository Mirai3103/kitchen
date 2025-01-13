package com.prj.restaurant_kitchen.entities;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MaterialBatch {
    @Id
    @GeneratedValue
    private int id;
    @Column(nullable = false)
    private int materialId;
    private int quantity;
    private LocalDateTime expiredDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "materialId", insertable = false, updatable = false)
    private Material material;

}
