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
      Ban ban = (Ban) request.getAttribute("ban");
      Phong phong = ban.getPhong();
      List<ChiTietBan> listChiTietBan = (List<ChiTietBan>) request.getAttribute("listChiTietBan");
    %>
 
     <div class="d-flex justify-content-between">
         <h2 class="mb-4">Đặt món cho <%= ban.getTenBan() %> - <%= phong.getTenPhong() %></h2>
        <a href="/order-table">Quay lại </a>
	</div>
    <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addItemModal">Thêm món</button>
    <table class="table table-hover">
        <thead class="table-light">
            <tr>
                <th>ID</th>
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
                <td><%= chiTiet.getMon().getTenMon() %></td>
                <td><%= chiTiet.getSoLuong() %></td>
                <td><%= String.format("%.2f", chiTiet.getDonGia()) %></td>
                <td><%= String.format("%.2f", chiTiet.getThanhTien()) %></td>
                <td><%= chiTiet.getStatus() %></td>
                <td>
                    <button class="btn btn-sm btn-danger"
                        onclick="cancelOrder(<%= chiTiet.getId() %>)" <% if (!chiTiet.getStatus().equals("Đang xử lý")) { %> disabled <% } %>
                    >Xóa</button>
                </td>
            </tr>
            <% 
                    } 
                } else { 
            %>
            <tr>
                <td colspan="6" class="text-center">Không có món nào được thêm.</td>
            </tr>
            <% } %>
        </tbody>
    </table>

    </div>

    <!-- Add Item Modal -->
    <div class="modal fade" id="addItemModal" tabindex="-1" aria-labelledby="addItemModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addItemModalLabel">Thêm món</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                <%
                List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
                %>
                    <form id="addItemForm">
                    
                        <div class="mb-3">
                            <label for="monSelect" class="form-label">Món</label>
                           <select class="form-select" id="monSelect" name="mon" required>
                              <option value="">Chọn món</option>
                              <% 
                                  if (menuItems != null && !menuItems.isEmpty()) {
                                      for (MenuItem menuItem : menuItems) { 
                              %>
                              <option value="<%= menuItem.getId() %>"><%= menuItem.getTenMon() %> - <%= String.format("%.2f", menuItem.getGia()) %>
                              
                              </option>
                              <% 
                                      } 
                                  } else { 
                              %>
                              <option value="" disabled>Không có món nào</option>
                              <% } %>
                          </select>
                        </div>
                        <div class="mb-3">
                            <label for="soLuongInput" class="form-label">Số lượng</label>
                            <input type="number" class="form-control" id="soLuongInput" required min="1" value="1">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-primary" onclick="addItem()">Thêm</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <script>
      

      async function addItem() {
          const mon = document.getElementById('monSelect');
          const soLuong = document.getElementById('soLuongInput');

    // Tạo object mới cho yêu cầu đặt món
          const newOrder = {
              roomId: <%= phong.getId() %>, // ID phòng
              tableId: <%= ban.getId() %>, // ID bàn
              menuItemId: parseInt(mon.value), // ID món
              quantity: parseInt(soLuong.value) // Số lượng
          };

          try {
              // Sử dụng fetch API để gửi yêu cầu đến server
              const response = await fetch('/api/order', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify(newOrder)
              });

              const result = await response.json();
              if (response.ok && result.status) {
                  alert('Đặt món thành công!');
                  window.location.reload();

        
              } else {

                  alert(result.message || 'Đặt món thất bại. Vui lòng thử lại!');
              }
          } catch (error) {
  
              console.error('Lỗi:', error);
              alert('Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại!');
          }
      }


        function cancelOrder(orderId) {
            if (confirm('Bạn có chắc chắn muốn huỷ món #'+ orderId + '?')) {
                fetch("/api/order/" + orderId, {
                    method: 'DELETE'
                })
                .then(response => response.json())
                .then(result => {
                    if (result.status) {
                        alert('Huỷ món thành công!');
                        window.location.reload();
                    } else {
                        alert(result.message || 'Huỷ món thất bại. Vui lòng thử lại!');
                    }
                })
                .catch(error => {
                    console.error('Lỗi:', error);
                    alert('Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại!');
                });
            }
        }


    </script>
</body>
</html>