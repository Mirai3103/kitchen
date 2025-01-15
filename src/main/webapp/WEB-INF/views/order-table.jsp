<%@ page import="com.prj.restaurant_kitchen.entities.Ban"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách bàn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-card {
            width: 150px;
            height: 150px;
            border: 2px solid #007bff;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: #ffffff;
        }
        .table-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }
        .table-card.occupied {
            border-color: #dc3545;
        }
        .table-status {
            font-size: 0.8rem;
            margin-top: 5px;
        }
        .back-link {
            text-decoration: none;
            color: #6c757d;
            transition: color 0.3s ease;
        }
        .back-link:hover {
            color: #343a40;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Danh sách bàn</h2>
        <a href="/home" class="back-link">
            <i class="fas fa-arrow-left me-2"></i>Quay lại
        </a>
    </div>
    <div class="row g-4">
        <%
            List<Ban> listBan = (List<Ban>)request.getAttribute("listBan");
            System.out.println(listBan.size());
            if(listBan != null) {
                for(Ban ban : listBan) {
        %>
        <div class="col-6 col-md-4 col-lg-3">
            <a href="datmon/<%= ban.getId() %>" class="text-decoration-none">
                <div class="table-card <%= ban.getStatus().equals("Trống") ? "" : "occupied" %>">
                    <h5><%= ban.getTenBan() %></h5>
                    <span class="table-status badge <%= ban.getStatus().equals("Trống") ? "bg-success" : "bg-danger" %>">
                                <%= ban.getStatus() %>
                            </span>
                    <small class="mt-2"><%= ban.getPhong().getTenPhong() %></small>
                </div>
            </a>
        </div>
        <%
                }
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>

