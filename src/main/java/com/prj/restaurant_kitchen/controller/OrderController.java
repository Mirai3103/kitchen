package com.prj.restaurant_kitchen.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.prj.restaurant_kitchen.entities.Order;
import com.prj.restaurant_kitchen.repository.OrderRepository;

import lombok.AllArgsConstructor;

import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order")
@AllArgsConstructor
public class OrderController {
    private final OrderRepository orderRepository;

    // Show order page
    @GetMapping
    public String showOrderForm() {
        return "order"; // This is the order.jsp page
    }

    // Handle order submission
    @PostMapping
    public String handleOrder(
            @RequestParam("email") String email,
            @RequestParam("fullName") String fullName,
            @RequestParam("phone") String phone,
            @RequestParam("address") String address,
            @RequestParam("province") String province,
            @RequestParam("district") String district,
            @RequestParam("ward") String ward,
            @RequestParam("notes") String notes,
            @RequestParam("paymentMethod") String paymentMethod,
            @RequestParam("totalAmount") double totalAmount,
            Model model) {

        // Create new Order object
        Order order = new Order();
        order.setEmail(email);
        order.setFullName(fullName);
        order.setPhone(phone);
        order.setAddress(address);
        order.setProvince(province);
        order.setDistrict(district);
        order.setWard(ward);
        order.setNotes(notes);
        order.setPaymentMethod(paymentMethod);
        order.setTotalAmount(totalAmount);

        // Save the order using the repository
        Order savedOrder = orderRepository.save(order);

        // Check if the order was saved successfully
        if (savedOrder != null) {
            if ("VNPAY-QR".equals(paymentMethod)) {
                // Redirect to VNPAY payment page
                return "redirect:/vnpay-payment";
            } else {
                // Show success message
                model.addAttribute("message", "Đặt hàng thành công!");
                return "order-success"; // This is the order-success.jsp page
            }
        } else {
            model.addAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại!");
            return "order"; // This is the order.jsp page
        }
    }
}