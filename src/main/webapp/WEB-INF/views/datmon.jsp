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
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .menu-item-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transform: translateY(-5px);
            transition: all 0.3s ease;
        }
        .order-table {
            max-height: 400px;
            overflow-y: auto;
        }
    </style>
</head>
<body class="bg-light">
<div class="container-fluid mt-4">
    <%
        Ban ban = (Ban) request.getAttribute("ban");
        Phong phong = ban.getPhong();
        List<ChiTietBan> listChiTietBan = (List<ChiTietBan>) request.getAttribute("listChiTietBan");
        List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    %>

    <div class="row mb-4">
        <div class="col">
            <h2 class="display-6">
                <i class="fas fa-utensils me-2"></i>
                Đặt món cho <%= ban.getTenBan() %> - <%= phong.getTenPhong() %>
            </h2>
        </div>
        <div class="col-auto d-flex gap-2">
          <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle" type="button" id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-bell-fill"></i>
                <span id="unreadCount" class="badge bg-danger"></span>
            </button>
            <ul class="dropdown-menu" aria-labelledby="notificationDropdown" id="notificationList">
                <!-- Notifications will be dynamically added here -->
            </ul>
        </div>
            <a href="/order-table" class="btn">
                <i class="fas fa-arrow-left me-2"></i>Quay lại
            </a>
        </div>
    </div>

    <div class="row">
        <!-- Danh sách món đã đặt -->
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-clipboard-list me-2"></i>Danh sách món đã đặt
                    </h5>
                </div>
                <div class="card-body order-table">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Món</th>
                            <th>Số lượng</th>
                            <th>Đơn giá</th>
                            <th>Thành tiền</th>
                            <th>Trạng thái</th>
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
                            <td>
                                <span class="badge bg-<%= chiTiet.getStatus().equals("Đang xử lý") ? "warning" : "success" %>">
                                    <%= chiTiet.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <%-- Nút Phục vụ: chỉ kích hoạt khi trạng thái là "Đợi phục vụ" --%>
                                <button class="btn btn-sm btn-secondary me-2"
                                        onclick="serveOrder(<%= chiTiet.getId() %>)"
                                        <% if (!"Đợi phục vụ".equals(chiTiet.getStatus())) { %>disabled<% } %>>
                                    <i class="fas fa-check"></i> Phục vụ
                                </button>

                                <%-- Nút Xóa: kích hoạt khi trạng thái là "Đang xử lý" --%>
                                <button class="btn btn-sm btn-danger"
                                        onclick="cancelOrder(<%= chiTiet.getId() %>)"
                                        <%= !chiTiet.getStatus().equals("Đang xử lý") ? "disabled" : "" %>>
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center">Không có món nào được thêm.</td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Form thêm món mới và nút "Đã phục vụ bàn này" -->
        <div class="col-md-4">
            <div class="card shadow-sm mb-3">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Thêm món mới</h5>
                </div>
                <div class="card-body">
                    <form id="addItemForm">
                        <div class="mb-3">
                            <label for="monSelect" class="form-label">Chọn món</label>
                            <select class="form-select" id="monSelect" name="mon" required>
                                <option value="">Chọn món</option>
                                <%
                                    if (menuItems != null && !menuItems.isEmpty()) {
                                        for (MenuItem menuItem : menuItems) {
                                %>
                                <option value="<%= menuItem.getId() %>">
                                    <%= menuItem.getTenMon() %> - <%= String.format("%.2f", menuItem.getGia()) %>
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
                        <button type="button" class="btn btn-primary w-100" onclick="addItem()">
                            <i class="fas fa-plus-circle me-2"></i>Thêm món
                        </button>
                    </form>
                </div>
            </div>
            <div class="text-center">
                <!-- Nút "Đã phục vụ bàn này" gọi API thông qua BanController -->
                <button class="btn btn-lg btn-success" onclick="finishService()">
                    <i class="fas fa-check-circle me-1"></i>Đã phục vụ bàn này
                </button>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col">
            <h3 class="mb-3">Thực đơn</h3>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <%
                    if (menuItems != null && !menuItems.isEmpty()) {
                        for (MenuItem menuItem : menuItems) {
                %>
                <div class="col">
                    <div class="card h-100 menu-item-card">
                        <img src="<%= menuItem.getHinhAnh() != null ? menuItem.getHinhAnh() : "/placeholder.jpg" %>" class="card-img-top" alt="<%= menuItem.getTenMon() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= menuItem.getTenMon() %></h5>
                            <p class="card-text">Giá: <%= String.format("%.2f", menuItem.getGia()) %></p>
                            <button class="btn btn-sm btn-outline-primary" onclick="quickAdd(<%= menuItem.getId() %>)">
                                <i class="fas fa-plus-circle me-2"></i>Thêm nhanh
                            </button>
                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="col-12">
                    <p class="text-center">Không có món nào trong thực đơn.</p>
                </div>
                <% } %>
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

        const newOrder = {
            roomId: <%= phong.getId() %>,
            tableId: <%= ban.getId() %>,
            menuItemId: parseInt(mon.value),
            quantity: parseInt(soLuong.value)
        };

        try {
            const response = await fetch('/api/order', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
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
        if (confirm('Bạn có chắc chắn muốn huỷ món #' + orderId + '?')) {
            fetch("/api/order/" + orderId, { method: 'DELETE' })
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

    function quickAdd(menuItemId) {
        const newOrder = {
            roomId: <%= phong.getId() %>,
            tableId: <%= ban.getId() %>,
            menuItemId: menuItemId,
            quantity: 1
        };

        fetch('/api/order', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(newOrder)
        })
            .then(response => response.json())
            .then(result => {
                if (result.status) {
                    alert('Đặt món nhanh thành công!');
                    window.location.reload();
                } else {
                    alert(result.message || 'Đặt món thất bại. Vui lòng thử lại!');
                }
            })
            .catch(error => {
                console.error('Lỗi:', error);
                alert('Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại!');
            });
    }

    function serveOrder(orderId) {
        if (confirm('Bạn có chắc chắn muốn phục vụ món #' + orderId + '?')) {
            fetch(`/api/order/served/\${orderId}`, {
                method: 'PUT'
            })
                .then(response => response.json())
                .then(result => {
                    if (result.status) {
                        alert('Phục vụ món thành công!');
                        window.location.reload();
                    } else {
                        alert(result.message || 'Phục vụ món thất bại. Vui lòng thử lại!');
                    }
                })
                .catch(error => {
                    console.error('Lỗi:', error);
                    alert('Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại!');
                });
        }
    }

    async function finishService() {
        const tableId = <%= ban.getId() %>;
        if (confirm('Bạn có chắc chắn đã phục vụ xong bàn này?')) {
            try {
                const response = await fetch(`/api/ban/\${tableId}/served`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                const result = await response.json();
                if (response.ok && result.status) {
                    alert(result.message || 'Bàn đã được đánh dấu là đã phục vụ!');

                    // Gọi API xóa danh sách ChiTietBan liên quan đến bàn này
                    const deleteResponse = await fetch(`/api/chitietban/byban/\${tableId}`, {
                        method: 'DELETE'
                    });
                    const deleteResult = await deleteResponse.json();
                    if (deleteResponse.ok && deleteResult.status) {
                        console.log(deleteResult.message);
                        listChiTietBan = null;
                        const orderTableBody = document.getElementById('orderTableBody');
                        if(orderTableBody) {
                            orderTableBody.innerHTML = `<tr>
                            <td colspan="7" class="text-center">Không có món nào được thêm.</td>
                        </tr>`;
                        }
                    } else {
                        console.error(deleteResult.message || 'Xóa danh sách món thất bại.');
                    }
                } else {
                    alert(result.message || 'Cập nhật trạng thái thất bại. Vui lòng thử lại!');
                }
            } catch (error) {
                console.error('Lỗi:', error);
                alert('Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại!');
            }
        }
    }

</script>
<script>
        // Sample notifications data (replace with actual data from your backend)
        let notifications = [];

        function updateNotifications() {
            const notificationList = document.getElementById('notificationList');
            const unreadCount = document.getElementById('unreadCount');
            
            // Clear existing notifications
            notificationList.innerHTML = '';
            
            // Count unread notifications
            const unreadNotifications = notifications.filter(n => !n.isRead).length;
            unreadCount.textContent = unreadNotifications > 0 ? unreadNotifications : '';
            
            // Add notifications to the dropdown
            notifications.forEach(notification => {
                const li = document.createElement('li');
                li.innerHTML = `
                    <a class="dropdown-item notification-item \${notification.isRead ? '' : 'unread'}" href="\${notification.navigationLink}" onclick="markAsRead(\${notification.id}, event)">
                        \${notification.message}
                        \${notification.isRead ? '' : '<span class="ms-2 badge bg-primary">Mới</span>'}
                    </a>
                `;
                notificationList.appendChild(li);
            });
            
          
        }

        function markAsRead(id, event) {
            event.preventDefault();
            const notification = notifications.find(n => n.id === id);
            deleteNotification(id, notification);
        }

        function deleteNotification(id, notification) {
            fetch('/api/notification/' + id, {
                method: 'DELETE'
            }).then(() => {
                notifications = notifications.filter(n => n.id !== id);
                updateNotifications();
               if( notification.navigationLink) window.location.href = notification.navigationLink;
            })
        }

     
      async  function fetchNoti(){
         const tableId = <%= ban.getId() %>;
            return fetch('/api/notification/table/'+tableId)
                .then(response => response.json())
                .then(data => {
                    notifications = data;
                    updateNotifications();
                });
        }
        fetchNoti();
        // Initial update

        // Simulating new notifications (for demo purposes)
        setInterval(() => {
            fetchNoti();
        }, 3000); // Add a new notification every 10 seconds
    </script>
</body>
</html>
