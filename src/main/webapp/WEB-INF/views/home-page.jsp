<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&display=swap" rel="stylesheet">
    <title>Trang Quản Lý Nhà Hàng</title>
    
</head>

<body>

    <header>
        <h1>Trang Quản Lý Nhà Hàng</h1>
        <p>Chào mừng bạn đến với hệ thống quản lý nhà hàng của chúng tôi!</p>
    </header>

    <nav>
        <a href="#">Trang Chủ</a>
        <a href="<%=request.getContextPath()%>/menu">Quản Lý Món Ăn</a>
        <a href="<%=request.getContextPath()%>/phong">Quản lý phòng/bàn</a>
        <a href="<%=request.getContextPath()%>/party">Quản lý phòng tiệc</a>
        <a href="<%=request.getContextPath()%>/order">thanh toán</a>
        <a href="#">Quản Lý Đơn Hàng</a>
        <a href="#">Quản Lý Hóa Đơn</a> 
        <a href="#">Doanh Thu</a>
        <a href="<%=request.getContextPath()%>/employee">Nhân Viên</a>
        <a href="<%=request.getContextPath()%>/customer">Khách hàng</a>
        <a href="<%=request.getContextPath()%>/restaurant">Đặt món</a>
        
    </nav>

    <div class="container">
        <div class="card">
            <h2>Thông Báo</h2>
            <p>Hệ thống đang vận hành ổn định. Chưa có đơn hàng chưa được xử lý.</p>
        </div>

        <div class="card">
            <h2>Quản Lý Món Ăn</h2>
            <p>Thêm, sửa, xóa các món ăn trong menu nhà hàng của bạn.</p>
            <a href="<%=request.getContextPath()%>/menu" class="button">Quản Lý Món Ăn</a>
        </div>

        <div class="card">
            <h2>Quản Lý Đặt Bàn</h2>
            <p>Quản lý các đơn đặt bàn của khách hàng, kiểm tra tình trạng bàn còn trống.</p>
            <a href="#" class="button">Quản Lý Đặt Bàn</a>
        </div>

        <div class="card">
            <h2>Quản Lý Đơn Hàng</h2>
            <p>Theo dõi đơn hàng và tình trạng đơn hàng của khách hàng.</p>
            <a href="#" class="button">Quản Lý Đơn Hàng</a>
        </div>

        <div class="card">
            <h2>Doanh Thu</h2>
            <p>Kiểm tra báo cáo doanh thu theo ngày, tuần hoặc tháng.</p>
            <a href="#" class="button">Xem Báo Cáo</a>
        </div>
    </div>

</body>

<style>
body {
           font-family: 'Noto Sans', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 1em 0;
        }
        nav {
            background-color: #333;
            overflow: hidden;
        }
        nav a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }
        nav a:hover {
            background-color: #ddd;
            color: black;
        }
        .container {
            padding: 20px;
        }
        .card {
            background-color: white;
            padding: 20px;
            margin: 10px 0;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card h2 {
            margin-top: 0;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px 0;
        }
        .button:hover {
            background-color: #45a049;
        }
</style>
</html>
