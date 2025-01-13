<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.prj.restaurant_kitchen.entities.ChiTietBan"%>
<%@ page import="com.prj.restaurant_kitchen.entities.Ban"%>
<%@ page import="com.prj.restaurant_kitchen.entities.Phong"%>
<%@ page import="com.prj.restaurant_kitchen.entities.MenuItem"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt bàn</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
   <% 
      List<ChiTietBan> listChiTietBan = (List<ChiTietBan>) request.getAttribute("listChiTietBan");
    %>
 
     <div class="d-flex justify-content-between">
         <h2 class="mb-4">Danh sách món cần làm </h2>
        <a href="/home">Quay lại </a>
	</div>
    <table class="table table-hover">
        <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Bàn - Phòng</th>
                <th>Món</th>
                <th>Số lượng</th>
                <th>Đơn giá</th>
                <th>Thành tiền</th>
                <th> Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody id="orderTableBody">
            <% 
                if (listChiTietBan != null && !listChiTietBan.isEmpty()) {
                    for (ChiTietBan chiTiet : listChiTietBan) { 
            %>
            <tr>
                <td><%= chiTiet.getId() %></td>
                <td><%= chiTiet.getBan().getTenBan() %> - <%= chiTiet.getPhong().getTenPhong() %></td>
                <td><%= chiTiet.getMon().getTenMon() %></td>
                <td><%= chiTiet.getSoLuong() %></td>
                <td><%= String.format("%.2f", chiTiet.getDonGia()) %></td>
                <td><%= String.format("%.2f", chiTiet.getThanhTien()) %></td>
                <td><%= chiTiet.getStatus() %></td>
                <td>
                    <button class="btn btn-sm btn-primary" 
                     
                    >
                    Nhận món
                    </button>
                    <button class="btn btn-sm btn-success"
                   >
                    Hoàn thành
                    </button>
                </td>
            </tr>
            <% 
                    } 
                } else { 
            %>
            <tr>
                <td colspan="6" class="text-center">Không có món nào cần làm.</td>
            </tr>
            <% } %>
        </tbody>
    </table>

    </div>

    <!-- Add Item Modal -->
 
    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <script>
      


    </script>
</body>
</html>