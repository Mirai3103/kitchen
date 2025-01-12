<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.prj.restaurant_kitchen.entities.Phong" %>
<html>
<head>
    <title>Quản lý phòng</title>
</head>
<body>
    <h1>Quản lý Phòng</h1>

    <!-- Hiển thị thông báo lỗi hoặc thành công -->
    <% 
        String error = (String) request.getAttribute("error");
        String message = (String) request.getAttribute("message");
        if (error != null) { 
    %>
        <p style="color: red;"><%= error %></p>
    <% } else if (message != null) { %>
        <p style="color: green;"><%= message %></p>
    <% } %>

    <h2>Danh sách Phòng</h2>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên phòng</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Phong> phongList = (List<Phong>) request.getAttribute("phongList");
                if (phongList != null && !phongList.isEmpty()) {
                    for (Phong phong : phongList) {
            %>
                        <tr>
                            <td><%= phong.getId() %></td>
                            <td><%= phong.getTenPhong() %></td>
                            <td>
                                <a href="phong?action=viewBans&idPhong=<%= phong.getId() %>">Xem Bàn</a>
                            </td>
                        </tr>
            <% 
                    }
                } else { 
            %>
                    <tr>
                        <td colspan="3">Không có phòng nào!</td>
                    </tr>
            <% } %>
        </tbody>
    </table>

    <h2>Thêm Phòng Mới</h2>
    <form method="post" action="phong">
        <label for="tenPhong">Tên phòng:</label>
        <input type="text" name="tenPhong" id="tenPhong" required>
        <input type="hidden" name="action" value="add">
        <button type="submit">Thêm Phòng</button>
    </form>
</body>
</html>
