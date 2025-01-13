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
    <style>
        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
    <div class="d-flex justify-content-between">
        <h2 class="mb-4">Danh sách bàn</h2>
        <a href="/home">Quay lại </a>
	</div>
       
        <table class="table table-hover">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Tên bàn</th>
                    <th>Trạng thái</th>
                    <th>Phòng</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<Ban> listBan = (List<Ban>)request.getAttribute("listBan");
                System.out.println(listBan.size());
                if(listBan != null) {
                    for(Ban ban : listBan) {
                %>
                    <tr>
                        <td><%= ban.getId() %></td>
                        <td><%= ban.getTenBan() %></td>
                        <td><%= ban.getStatus() %></td>
                        <td><%= ban.getPhong().getTenPhong() %></td>
                        <td>
                            <a href="datmon/<%= ban.getId() %>" class="btn btn-primary btn-sm">Đặt món</a>
                        </td>
                    </tr>
                <%
                    }
                }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>