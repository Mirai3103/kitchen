package com.prj.restaurant_kitchen.controller;

import com.prj.restaurant_kitchen.entities.MenuItem;
import com.prj.restaurant_kitchen.repository.MenuItemRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {

    private static final String IMAGE_DIR = "src/main/webapp/images";

    @Autowired
    private MenuItemRepository menuRepository;

    @GetMapping
    public String listMenuItems(Model model) {
        List<MenuItem> menuItems = menuRepository.findAll();
        System.out.println(menuItems);
        model.addAttribute("menuItems", menuItems);
        return "product"; // Trả về trang product.jsp
    }

    @PostMapping
    public String handleMenuAction(@RequestParam("action") String action,
            @RequestParam(value = "ten_mon", required = false) String tenMon,
            @RequestParam(value = "gia", required = false) Double gia,
            @RequestParam(value = "mo_ta", required = false) String moTa,
            @RequestParam(value = "nguyen_lieu", required = false) String nguyenLieu,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "hinh_anh", required = false) MultipartFile file,
            @RequestParam(value = "id", required = false) Integer id,
            Model model) throws IOException {

        switch (action) {
            case "add":
                return addMenuItem(tenMon, gia, moTa, nguyenLieu, category, file, model);
            case "update":
                return updateMenuItem(id, tenMon, gia, moTa, nguyenLieu, category, file, model);
            case "delete":
                return deleteMenuItem(id, model);
            default:
                model.addAttribute("status", "invalid_action");
                return "redirect:/menu"; // Nếu action không hợp lệ, quay lại trang menu
        }
    }

    private String addMenuItem(String tenMon, Double gia, String moTa, String nguyenLieu, String category,
            MultipartFile file, Model model) throws IOException {
        if (tenMon == null || gia <= 0 || moTa == null || nguyenLieu == null || file.isEmpty() || category == null) {
            model.addAttribute("status", "invalid_data");
            return "redirect:/menu";
        }

        String HinhAnh = uploadImage(file);

        MenuItem menuItem = new MenuItem();
        menuItem.setTenMon(tenMon);
        menuItem.setGia(gia);
        menuItem.setMoTa(moTa);
        menuItem.setNguyenLieu(nguyenLieu);
        menuItem.setCategory(category);
        menuItem.setHinhAnh(HinhAnh);

        menuRepository.save(menuItem);

        return "redirect:/menu"; // Sau khi thêm xong, quay lại trang menu
    }

    private String updateMenuItem(Integer id, String tenMon, Double gia, String moTa, String nguyenLieu,
            String category, MultipartFile file, Model model) throws IOException {
        if (id == null || id <= 0) {
            model.addAttribute("status", "invalid_id");
            return "redirect:/menu";
        }

        MenuItem menuItem = menuRepository.findById(id).orElse(null);
        if (menuItem == null) {
            model.addAttribute("status", "item_not_found");
            return "redirect:/menu";
        }

        String HinhAnh = file.isEmpty() ? menuItem.getHinhAnh() : uploadImage(file); // Nếu không thay đổi ảnh, giữ tên
                                                                                     // ảnh cũ

        menuItem.setTenMon(tenMon);
        menuItem.setGia(gia);
        menuItem.setMoTa(moTa);
        menuItem.setNguyenLieu(nguyenLieu);
        menuItem.setCategory(category);
        menuItem.setHinhAnh(HinhAnh);

        menuRepository.save(menuItem); // Cập nhật món ăn trong cơ sở dữ liệu

        return "redirect:/menu"; // Sau khi cập nhật xong, quay lại trang menu
    }

    private String deleteMenuItem(Integer id, Model model) {
        if (id == null || id <= 0) {
            model.addAttribute("status", "invalid_id");
            return "redirect:/menu";
        }

        menuRepository.deleteById(id); // Xóa món ăn khỏi cơ sở dữ liệu

        return "redirect:/menu"; // Quay lại trang menu sau khi xóa
    }

    @GetMapping("/search")
    public String searchMenuItems(@RequestParam("ten_mon") String tenMon, Model model) {
        if (tenMon == null || tenMon.isEmpty()) {
            return "redirect:/menu?status=invalid_search";
        }

        List<MenuItem> menuItems = menuRepository.findByTenMonContaining(tenMon);
        model.addAttribute("menuItems", menuItems);

        return "product"; // Trả về trang product.jsp với kết quả tìm kiếm
    }

    private String uploadImage(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return null;
        }

        String uploadDir = System.getProperty("user.dir") + File.separator + IMAGE_DIR;

        // Tạo thư mục nếu chưa tồn tại
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String HinhAnh = file.getOriginalFilename();
        File serverFile = new File(uploadDir + File.separator + HinhAnh);
        file.transferTo(serverFile);

        return HinhAnh; // Trả về tên file để lưu vào cơ sở dữ liệu
    }
}