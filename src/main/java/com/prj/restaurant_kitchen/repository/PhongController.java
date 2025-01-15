package com.prj.restaurant_kitchen.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.prj.restaurant_kitchen.entities.Ban;
import com.prj.restaurant_kitchen.entities.Phong;

import java.util.List;

@Controller
@RequestMapping("/phong")
public class PhongController {

    @Autowired
    private PhongRepository phongRepository;

    @Autowired
    private BanRepository banRepository;

    @GetMapping
    public String handleGet(@RequestParam(value = "action", required = false, defaultValue = "viewBans") String action,
            @RequestParam(value = "idPhong", required = false, defaultValue = "0") Integer idPhong,
            Model model) {

        if ("viewBans".equals(action)) {
            List<Ban> banList;
            if (idPhong == 0) {
                banList = banRepository.findAll();
            } else {
                banList = banRepository.findByIdPhong(idPhong);
            }
            model.addAttribute("banList", banList);
            model.addAttribute("idPhong", idPhong);

            if (banList.isEmpty()) {
                model.addAttribute("message", "Không có bàn nào trong phòng này.");
            }
            return "ban";
        } else {
            List<Phong> phongList = phongRepository.findAll();
            model.addAttribute("phongList", phongList);
            return "room";
        }
    }

    @PostMapping
    public String handlePost(@RequestParam("action") String action,
            @RequestParam(value = "tenBan", required = false) String tenBan,
            @RequestParam(value = "idPhong", required = false) Integer idPhong,
            @RequestParam(value = "status", required = false) String status,
                @RequestParam(value = "tenPhong", required = false) String tenPhong,
            RedirectAttributes redirectAttributes) {

        if ("addBan".equals(action)) {
            if (tenBan == null || tenBan.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên bàn không được để trống.");
                redirectAttributes.addAttribute("idPhong", idPhong);
                return "redirect:/phong?action=viewBans&idPhong=" + idPhong;
            }

            try {
                Ban newBan = new Ban();
                newBan.setIdPhong(idPhong);
                newBan.setTenBan(tenBan);
                newBan.setStatus(status != null ? status : "available");

                banRepository.save(newBan);
                return "redirect:/phong?action=viewBans&idPhong=" + idPhong;

            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Không thể thêm bàn.");
                redirectAttributes.addAttribute("idPhong", idPhong);
                return "redirect:/phong?action=viewBans&idPhong=" + idPhong;
            }
        } else if ("addRoom".equals(action)) {
            if (tenPhong == null || tenPhong.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên phòng không được để trống.");
                return "redirect:/phong";
            }

            try {
                Phong phong = new Phong();
                phong.setTenPhong(tenPhong);
                phongRepository.save(phong);
                return "redirect:/phong";

            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Không thể thêm phòng.");
                return "redirect:/phong";
            }
        }

        return "redirect:/phong";
    }
}