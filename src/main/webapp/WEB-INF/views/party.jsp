<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.prj.restaurant_kitchen.entities.BookParty" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Tiệc</title>
</head>
<body>
    <div class="container">
        <h1>Quản Lý Tiệc</h1>
        
        <%
        String status = (String) request.getAttribute("status");
        if (status != null) {
            if (status.equals("success")) {
        %>
            <div class="message success">Thao tác thành công!</div>
        <%
            } else if (status.equals("error")) {
        %>
            <div class="message error">Có lỗi xảy ra. Vui lòng thử lại.</div>
        <%
            }
        }
        %>

        <h2>Danh Sách Tiệc</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Loại</th>
                <th>Hình Ảnh</th>
                <th>Số Lượng</th>
                <th>Thao Tác</th>
            </tr>
            <%
            List<BookParty> parties = (List<BookParty>) request.getAttribute("parties");
            if (parties != null && !parties.isEmpty()) {
                for (BookParty party : parties) {
            %>
                <tr>
                    <td><%= party.getId() %></td>
                    <td><%= party.getTen() %></td>
                    <td><%= party.getLoai() %></td>
                    <td><img src="images/<%= party.getHinhAnh() %>" alt="<%= party.getTen() %>" width="100"></td>
                    <td><%= party.getSoLuong() %></td>
                    <td>
                        <form action="party" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= party.getId() %>">
                            <input type="submit" value="Xóa" onclick="return confirm('Bạn có chắc muốn xóa tiệc này?');">
                        </form>
                    </td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="6">Không có tiệc nào.</td>
                </tr>
            <%
            }
            %>
        </table>

        <h2>Thêm Tiệc Mới</h2>
        <form action="party" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label for="ten">Tên Tiệc:</label>
                <input type="text" id="ten" name="ten" required>
            </div>
            <div class="form-group">
                <label for="loai">Loại Tiệc:</label>
                <select id="loai" name="loai" required>
                    <option value="">Chọn loại tiệc</option>
                    <option value="sinh_nhat">Sinh nhật</option>
                    <option value="tiec_cuoi">Tiệc Cưới</option>
                    <option value="hen_ho">Hẹn hò</option>
                    <option value="hoi_thao">Hội thảo Công ty</option>
                    <option value="khai_truong">Lễ khai trương</option>
                </select>
            </div>
            <div class="form-group">
                <label for="hinh_anh">Hình Ảnh:</label>
                <input type="file" id="hinh_anh" name="hinh_anh" required>
            </div>
            <div class="form-group">
                <label for="soLuong">Số Lượng:</label>
                <input type="number" id="soLuong" name="soLuong" min="1" required>
            </div>
            <input type="submit" value="Thêm Tiệc">
        </form>
    </div>
</body>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</html>