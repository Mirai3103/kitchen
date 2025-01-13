package com.prj.restaurant_kitchen.entities;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Material {
    @Id
    @GeneratedValue
    private int id;
    private String name;
    private String unit;
    private String description;

    @OneToMany(mappedBy = "material", fetch = FetchType.LAZY)
    private List<MaterialBatch> materialBatches;
}
