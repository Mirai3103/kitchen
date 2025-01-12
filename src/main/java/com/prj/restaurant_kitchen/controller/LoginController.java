package com.prj.restaurant_kitchen.controller;

import com.prj.restaurant_kitchen.entities.User;
import com.prj.restaurant_kitchen.repository.UserRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("userLogin") // Để lưu trữ đối tượng userLogin trong session
public class LoginController {

    @Autowired
    private UserRepository userDao;

    // Xử lý yêu cầu GET để hiển thị form đăng nhập
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // Chuyển hướng tới trang login.jsp
    }

    // Xử lý yêu cầu POST khi người dùng gửi form đăng nhập
    @PostMapping("/login")
    public String login(@RequestParam("username") String userName,
            @RequestParam("password") String password,
            HttpSession session, Model model) {

        try {
            // Kiểm tra thông tin đăng nhập
            var userOpt = userDao.loginUser(userName, password);
            if (userOpt.isPresent()) {
                // Đăng nhập thành công, lưu người dùng vào session
                session.setAttribute("userLogin", userOpt.get());
                return "redirect:/home"; // Chuyển hướng tới trang home
            } else {
                // Đăng nhập thất bại
                model.addAttribute("loginFail", "User name or password is incorrect");
                return "login"; // Quay lại trang login với thông báo lỗi
            }
        } catch (Exception e) {
            // Xử lý lỗis
            model.addAttribute("error", "An error occurred while processing your request.");
            return "login"; // Quay lại trang login với thông báo lỗi
        }
    }

    // @Override
    // protected void doGet(HttpServletRequest request, HttpServletResponse
    // response)
    // throws ServletException, IOException {
    // LogFactory.getLogger().info("Logging out");
    // // remove session userLogin
    // request.getSession().removeAttribute("userLogin");
    // // redirect to /login
    // response.sendRedirect(request.getContextPath() + "/login");
    // }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // Xóa thông tin người dùng khỏi session
        session.removeAttribute("userLogin");
        return "redirect:/login"; // Chuyển hướng về trang login
    }
}
