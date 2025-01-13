package com.prj.restaurant_kitchen.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity()
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "chi_tiet_ban")
public class ChiTietBan {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(nullable = false)
	private int idPhong;

	@ManyToOne()
	@JoinColumn(name = "idPhong", insertable = false, updatable = false)
	private Phong phong;

	@Column(nullable = false)
	private int idBan;

	@ManyToOne()
	@JoinColumn(name = "idBan", insertable = false, updatable = false)
	private Ban ban;

	@Column(nullable = false)
	private int idMon;

	@ManyToOne()
	@JoinColumn(name = "idMon", insertable = false, updatable = false)
	private MenuItem mon;

	@Column(nullable = false)
	private int soLuong;

	@Column(nullable = false)
	private double donGia;

	@Transient // Không lưu trường này vào cơ sở dữ liệu
	private double thanhTien;
	@Column(nullable = true)
	private String status = "Đang xử lý";

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
