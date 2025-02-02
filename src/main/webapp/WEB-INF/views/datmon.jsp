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
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .card {
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 0.5rem;
            border-top-right-radius: 0.5rem;
        }
        .menu-item-card:hover {
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        }
        .order-table {
            max-height: 400px;
            overflow-y: auto;
        }
        .btn-primary {
            background-color: #4e73df;
            border-color: #4e73df;
        }
        .btn-primary:hover {
            background-color: #2e59d9;
            border-color: #2e59d9;
        }
        .btn-success {
            background-color: #1cc88a;
            border-color: #1cc88a;
        }
        .btn-success:hover {
            background-color: #17a673;
            border-color: #17a673;
        }
        .table th {
            background-color: #f8f9fc;
            color: #4e73df;
            font-weight: 600;
        }
    </style>
</head>
<body class="bg-light">
<div class="container-fluid mt-4" x-data="currentTableData()" x-init="init()">
    <%
        Ban ban = (Ban) request.getAttribute("ban");
        Phong phong = ban.getPhong();
        List<ChiTietBan> listChiTietBan = (List<ChiTietBan>) request.getAttribute("listChiTietBan");
        List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    %>

    <div class="row mb-4">
        <div class="col">
            <h2 class="display-6 text-primary">
                <i class="fas fa-utensils me-2"></i>
                Đặt món cho <%= ban.getTenBan() %> - <%= phong.getTenPhong() %>
            </h2>
        </div>
        <div class="col-auto d-flex gap-2">
            <div class="dropdown">
                <button class="btn btn-outline-primary dropdown-toggle" type="button" id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-bell"></i>
                    <span id="unreadCount" class="badge bg-danger"></span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown" id="notificationList">
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
                        <template x-for="item in listChiTietBan" :key="item.id">
                            <tr>
                                <td x-text="item.id"></td>
                                <td x-text="item.mon.tenMon"></td>
                                <td x-text="item.soLuong"></td>
                                <td x-text="formatVietnameseCurrency(item.mon.gia)"></td>
                                <td x-text="formatVietnameseCurrency(item.thanhTien)"></td>
                                <td>
                                    <span x-bind:class="'badge ' + (item.status === 'Đang xử lý' ? 'bg-warning' : 'bg-success')">
                                        <span x-text="item.status"></span>
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-secondary me-2"
                                            x-on:click="serveOrder(item.id)"
                                            x-bind:disabled="item.status !== 'Đợi phục vụ'">
                                        <i class="fas fa-check"></i> Phục vụ
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger"
                                            x-on:click="cancelOrder(item.id)"
                                            x-bind:disabled="item.status !== 'Đang xử lý'">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-warning"
                                            x-on:click="rushFood(item.id)"
                                            x-bind:disabled="item.status !== 'Đang xử lý' || item.needsRush">
                                        <i class="fas fa-bolt"></i> Làm gấp
                                    </button>
                                </td>
                            </tr>
                        </template>
                        <tr x-show="listChiTietBan.length === 0">
                            <td colspan="7" class="text-center">Không có món nào được thêm.</td>
                        </tr>
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
                <button class="btn btn-lg btn-success" onclick="finishService()">
                    <i class="fas fa-check-circle me-1"></i>Đã phục vụ bàn này
                </button>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col">
            <h3 class="mb-3 text-primary">Thực đơn</h3>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <%
                    if (menuItems != null && !menuItems.isEmpty()) {
                        for (MenuItem menuItem : menuItems) {
                            String imagePath = menuItem.getHinhAnh() != null
                                    ? "/images/" + menuItem.getHinhAnh()
                                    : "/images/placeholder.jpg";
                %>
                <div class="col">
                    <div class="card h-100 menu-item-card">
                        <img src="<%= imagePath %>" class="card-img-top" alt="<%= menuItem.getTenMon() %>">
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

<script>

    function currentTableData() {
        return {
            tableId: 1,
            listChiTietBan: [],
            fetchCurrentTableOrder() {
                const tableId = this.tableId; // Sử dụng `this.tableId` để lấy giá trị từ đối tượng
                fetch(`/api/order/by-table/\${tableId}`)
                    .then(response => response.json())
                    .then(data => {
                        this.listChiTietBan = data;
                    })
                    .catch(error => {
                        console.error("Error fetching table order:", error);
                    });
            },
            init() {
                this.fetchCurrentTableOrder();
                setInterval(() => {
                    this.fetchCurrentTableOrder();
                }, 3000); // Cập nhật danh sách món mỗi 3 giây
            },
            formatVietnameseCurrency(value) {
                if (typeof value !== 'number') {
                    return value;
                }
                return new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(value);
            }
        };
    }
        // Simulating new notifications (for demo purposes)
        setInterval(() => {
            fetchNoti();
        }, 3000); // Add a new notification every 10 seconds
    </script>

<script>

 function currentTableData() {
    return {
        tableId: <%= ban.getId() %>,
        listChiTietBan: [],
        fetchCurrentTableOrder() {
            const tableId = this.tableId; // Sử dụng `this.tableId` để lấy giá trị từ đối tượng
            fetch(`/api/order/by-table/\${tableId}`)
                .then(response => response.json())
                .then(data => {
                    this.listChiTietBan = data;
                })
                .catch(error => {
                    console.error("Error fetching table order:", error);
                });
        },
        init() {
            this.fetchCurrentTableOrder();
            setInterval(() => {
                this.fetchCurrentTableOrder();
            }, 3000); // Cập nhật danh sách món mỗi 3 giây
        },
        formatVietnameseCurrency(value) {
            if (typeof value !== 'number') {
                return value;
            }
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(value);
        },
        async rushFood(id) {
            if (confirm('Bạn có chắc chắn muốn đặt gấp món #' + id + '?')) {
                try {
                    const response = await fetch(`/api/order/\${id}/rush`, {
                        method: 'PUT'
                    });
                    const result = await response.json();
                    if (response.ok && result.status) {
                        alert('Đặt gấp món thành công!');
                        this.fetchCurrentTableOrder();
                    } else {
                        alert(result.message || 'Đặt gấp món thất bại. Vui lòng thử lại!');
                    }
                } catch (error) {
                    console.error('Lỗi:', error);
                    alert('Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại!');
                }
            }
        }
    };

   
}

</script>
</body>
</html>