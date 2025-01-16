<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.prj.restaurant_kitchen.entities.ChiTietBan"%>
<%@ page import="com.prj.restaurant_kitchen.entities.Ban"%>
<%@ page import="com.prj.restaurant_kitchen.entities.Phong"%>
<%@ page import="com.prj.restaurant_kitchen.entities.MenuItem"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đơn hàng nhà bếp</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Alpine.js -->
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            max-width: 1200px;
        }
        h2 {
            color: #2c3e50;
            font-weight: 600;
        }
        .order-list {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .order-item {
            border-bottom: 1px solid #e9ecef;
            transition: all 0.3s ease;
            padding: 1.5rem;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .order-item:hover {
            background-color: #f8f9fa;
        }
        .dish-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
        }
        .order-details {
            font-size: 0.9rem;
            color: #5a6a7e;
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 0.3rem 0.6rem;
            border-radius: 20px;
            font-weight: 500;
        }
        .priority-badge {
            font-size: 0.75rem;
            padding: 0.2rem 0.5rem;
            border-radius: 12px;
            font-weight: 600;
        }
        .btn-action {
            padding: 0.4rem 0.8rem;
            font-size: 0.85rem;
            border-radius: 20px;
            transition: all 0.2s ease;
            white-space: nowrap;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .modal-content {
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .modal-header {
            background-color: #3498db;
            color: #ffffff;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .modal-body {
            padding: 2rem;
        }
        .ingredients-table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }
        .ingredients-table th {
            background-color: #ecf0f1;
            font-weight: 600;
        }
        .ingredients-table td, .ingredients-table th {
            padding: 0.75rem 1rem;
        }
    </style>
</head>
<body>
<div class="container mt-5" x-data="orderData()" x-init="init()">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-utensils me-2"></i>Danh sách món cần làm</h2>
        <div>

          <div class="d-flex gap-2">
          <a href="/material" class="btn btn-primary me-2">
                <i class="fas fa-box me-1"></i>Xem kho nguyên liệu
            </a>
            <a href="/home" class="btn btn-outline-secondary">
                <i class="fas fa-home me-1"></i>Quay lại
            </a>
             <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle" type="button" id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-bell-fill"></i>
                <span id="unreadCount" class="badge bg-danger" x-text="needsRushes.length" x-show="needsRushes.length > 0">
                </span>
            </button>
            <ul class="dropdown-menu" aria-labelledby="notificationDropdown" id="notificationList">
                <template x-for="item in needsRushes" :key="item.id">
                    <li>
                        <a class="dropdown-item" href="#">
                            <strong x-text="item.ban.tenBan + ' - ' + item.phong.tenPhong"></strong> cần gấp làm món <strong x-text="item.mon.tenMon"></strong>
                        </a>
                    </li>
                </template>
            </ul>
        </div>
          </div>
        </div>
    </div>

    <div class="order-list">
          <template x-for="(list, index) in mergeList" :key="index">
            <div class="order-item">
                <div class="row align-items-center">
                    <div class="col-lg-4 col-md-6 mb-3 mb-lg-0">
                        <h5 class="dish-name mb-2" x-text="list[0].mon.tenMon">
                        </h5>

                         <template x-for="item in list" :key="item.id">
                            <p class="order-details mb-0"><strong>Bàn - Phòng:</strong> <span x-text="item.ban.tenBan + ' - ' + item.phong.tenPhong"></span>
                            <b> x<span x-text="item.soLuong"></span></b>
                             <span class="priority-badge mt-1 bg-danger text-white"
                              x-show="item.needsRush">
                                Cần gấp
                              </span>
                            </p>

                        </template>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-3 mb-lg-0">
                        <p class="order-details mb-1"><strong>Tổng số lượng:</strong> <span x-text="list.reduce((acc, item) => acc + item.soLuong, 0)"></span> </p>
                        <p class="order-details mb-0"><strong>Đặt lúc:</strong> <span x-text="formatDate(list[0].createdAt)"></span></p>
                    </div>
                    <div class="col-lg-2 col-md-6 mb-3 mb-lg-0">
                        <span class="status-badge me-2"
                              :class="{
                                  'bg-warning text-dark': list[0].status === 'Đang xử lý',
                                  'bg-info text-white': list[0].status === 'Đang nấu',
                              }"
                              x-text="list[0].status"></span>
                        <span class="priority-badge"
                              :class="{
                                  'bg-danger text-white': list[0].priority === 'High',
                                  'bg-warning text-dark': list[0].priority === 'Medium',
                                  'bg-info text-white': list[0].priority === 'Low'
                              }"
                              x-text="list[0].priority"></span>


                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column flex-sm-row justify-content-lg-end align-items-stretch gap-2">
                            <button class="btn btn-outline-info btn-sm btn-action flex-grow-1"
                                    @click="viewIngredients(list[0].mon.id)">
                                <i class="fas fa-list-ul me-1"></i>Xem nguyên liệu
                            </button>
                            <button class="btn btn-primary btn-sm btn-action flex-grow-1"
                                    x-show="list[0].status === 'Đang xử lý'"
                                    @click="list.forEach(item => startCooking(item.id))"
                                    >
                                <i class="fas fa-fire me-1"></i>Nhận món
                            </button>
                            <button class="btn btn-success btn-sm btn-action flex-grow-1"
                                    x-show="list[0].status === 'Đang nấu'"
                                    @click="list.forEach(item => finishCooking(item.id))"
                                    >
                                <i class="fas fa-check me-1"></i>Hoàn thành nấu
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </template>

        <div class="p-4" x-show="listChiTietBan.length === 0">
            <div class="alert alert-info text-center mb-0">Không có món nào cần làm.</div>
        </div>
    </div>

    <!-- Ingredients Modal -->
    <div class="modal fade" id="ingredientsModal" tabindex="-1" aria-labelledby="ingredientsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ingredientsModalLabel">
                        <i class="fas fa-list-ul me-2"></i>Danh sách nguyên liệu
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-bordered ingredients-table">
                            <thead>
                            <tr>
                                <th>Tên nguyên liệu</th>
                                <th>Số lượng</th>
                                <th>Đơn vị</th>
                            </tr>
                            </thead>
                            <tbody>
                            <template x-for="ingredient in currentRecipe" :key="ingredient.id">
                                <tr>
                                    <td x-text="ingredient.material.name"></td>
                                    <td x-text="ingredient.quantity"></td>
                                    <td x-text="ingredient.material.unit"></td>
                                </tr>
                            </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS và Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

<script>
    function orderData() {
        return {
            listChiTietBan: [],
            currentRecipe: [],
            ingredientsModal: null,
            mergeList: [],
            needsRushes: [],
            async init() {
                this.listChiTietBan = await this.getAllOrderItem();
                this.ingredientsModal = new bootstrap.Modal(document.getElementById('ingredientsModal'));
                setInterval(async () => {
                    this.listChiTietBan = await this.getAllOrderItem();
                }, 5000);
            },
            async getAllOrderItem() {
                const response = await fetch('/api/order/kitchen', {
                    method: 'GET'
                });
                if (response.ok) {
                    const orders = await response.json();
                    const mapIdStatus = new Map();
                    const allowStatus = ['Đang xử lý', 'Đang nấu'];
                    order =orders.map(order => {
                        const waitingTime = new Date() - new Date(order.createdAt);
                        if (waitingTime > 30 * 60 * 100) { // More than 30 minutes
                            order.priority = 'High';
                        } else if (waitingTime > 15 * 60 * 100) { // More than 15 minutes
                            order.priority = 'Medium';
                        } else {
                            order.priority = 'Low';
                        }
                        return order;
                    });
                    this.needsRushes = orders.filter(item => item.needsRush).sort((a, b) => new Date(a.createdAt) - new Date(b.createdAt));
                    orders.forEach(item => {
                        if (!allowStatus.includes(item.status)) {
                            return;
                        }
                        const key = `\${item.idMon}-\${item.status}`;
                        if (!mapIdStatus.has(key)) {
                            mapIdStatus.set(key, []);
                        }
                        mapIdStatus.get(key).push(item);
                    });
                    const merge = Array.from(mapIdStatus.values());
                    const unmergedList = orders.filter(item => !allowStatus.includes(item.status)).map(item => [item]);
                    this.mergeList= [...merge, ...unmergedList];
                    this.mergeList.sort((a, b) => {
                        if (a.some(item => item.needsRush) && !b.some(item => item.needsRush)) {
                            return -1;
                        }
                        if (!a.some(item => item.needsRush) && b.some(item => item.needsRush)) {
                            return 1;
                        }
                        return 0;
                    });

                    return orders;

                }
                return [];
            },
            async startCooking(id) {
                fetch(`/api/order/start-cooking/\${id}`, {
                    method: 'PUT'
                }).then(response => response.json())
                    .then(status => {
                        if (status.message) {
                            alert(status.message);
                        } else {
                            this.updateOrderStatus(id, 'Đang nấu');
                        }
                    }).catch(error => {
                    console.error(error);
                });
            },
            async finishCooking(id) {
                const response = await fetch(`/api/order/finish-cooking/\${id}`, {
                    method: 'PUT'
                });
                if (response.ok) {
                    this.updateOrderStatus(id, 'Đợi phục vụ');
                }
            },
            async served(id) {
                const response = await fetch(`/api/order/served/\${id}`, {
                    method: 'PUT'
                });
                if (response.ok) {
                    this.updateOrderStatus(id, 'Đã phục vụ');
                }
            },
            updateOrderStatus(id, newStatus) {
                const index = this.listChiTietBan.findIndex(item => item.id === id);
                if (index !== -1) {
                    this.listChiTietBan[index].status = newStatus;
                }
            },
            formatCurrency(value) {
                return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
            },
            formatDate(dateString) {
                return new Date(dateString).toLocaleString('vi-VN');
            },
            async viewIngredients(menuItemId) {
                this.currentRecipe = await this.getMenuItemRecipe(menuItemId);
                this.ingredientsModal.show();
            },
            async getMenuItemRecipe(id) {
                const response = await fetch(`/api/menuItem/\${id}/recipe`, {
                    method: 'GET'
                });
                if (response.ok) {
                    return await response.json();
                }
                return [];
            }
        }
    }

</script>
</body>
</html>