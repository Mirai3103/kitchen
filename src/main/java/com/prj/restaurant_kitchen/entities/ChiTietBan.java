package com.prj.restaurant_kitchen.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChiTietBan {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(nullable = false)
	private int idPhong;

	@Column(nullable = false)
	private int idBan;

	@Column(nullable = false)
	private int idMon;

	@Column(nullable = false)
	private int soLuong;

	@Column(nullable = false)
	private double donGia;

	@Transient // Không lưu trường này vào cơ sở dữ liệu
	private double thanhTien;

	// Custom Setter for `soLuong` and `donGia` to calculate `thanhTien`
	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
		this.thanhTien = this.soLuong * this.donGia;
	}

	public void setDonGia(double donGia) {
		this.donGia = donGia;
		this.thanhTien = this.soLuong * this.donGia;
	}

	public double getThanhTien() {
		return this.soLuong * this.donGia; // Tính toán động thay vì lưu giá trị
	}
}
