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
        .order-card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .order-card .card-header {
            background-color: #3498db;
            color: #ffffff;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            padding: 15px;
        }
        .order-card .card-body {
            padding: 20px;
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 5px 10px;
            border-radius: 20px;
        }
        .btn-action {
            border-radius: 20px;
            padding: 5px 15px;
            font-size: 0.9rem;
            margin-right: 5px;
            margin-bottom: 5px;
        }
        .modal-content {
            border-radius: 15px;
        }
        .modal-header {
            background-color: #3498db;
            color: #ffffff;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .modal-body {
            padding: 20px;
        }
        .ingredients-table {
            border-radius: 10px;
            overflow: hidden;
        }
        .ingredients-table th {
            background-color: #ecf0f1;
        }
    </style>
</head>
<body>
<div class="container mt-5" x-data="orderData()" x-init="init()">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-utensils me-2"></i>Danh sách món cần làm</h2>
        <div>
            <a href="/material" class="btn btn-primary me-2">
                <i class="fas fa-box me-1"></i>Xem kho nguyên liệu
            </a>
            <a href="/home" class="btn btn-outline-secondary">
                <i class="fas fa-home me-1"></i>Quay lại
            </a>
        </div>
    </div>

    <div class="row" id="orderCardContainer">
        <template x-for="chiTiet in listChiTietBan" :key="chiTiet.id">
            <div class="col-md-6 col-lg-4">
                <div class="order-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0" x-text="chiTiet.mon.tenMon"></h5>
                        <span class="status-badge"
                              :class="{
                                  'bg-warning': chiTiet.status === 'Đang xử lý',
                                  'bg-info': chiTiet.status === 'Đang nấu',
                              }"
                              x-text="chiTiet.status"></span>
                    </div>
                    <div class="card-body">
                        <p><strong>ID:</strong> <span x-text="chiTiet.id"></span></p>
                        <p><strong>Bàn - Phòng:</strong> <span x-text="chiTiet.ban.tenBan + ' - ' + chiTiet.phong.tenPhong"></span></p>
                        <p><strong>Số lượng:</strong> <span x-text="chiTiet.soLuong"></span></p>
                        <p><strong>Đơn giá:</strong> <span x-text="formatCurrency(chiTiet.donGia)"></span></p>
                        <p><strong>Thành tiền:</strong> <span x-text="formatCurrency(chiTiet.thanhTien)"></span></p>
                        <p><strong>Đặt lúc:</strong> <span x-text="formatDate(chiTiet.createdAt)"></span></p>
                        <div class="mt-3">
                            <button class="btn btn-outline-info btn-action"
                                    @click="viewIngredients(chiTiet.mon.id)">
                                <i class="fas fa-list-ul me-1"></i>Xem nguyên liệu
                            </button>
                            <button class="btn btn-primary btn-action"
                                    x-show="chiTiet.status === 'Đang xử lý'"
                                    @click="startCooking(chiTiet.id)">
                                <i class="fas fa-fire me-1"></i>Nhận món
                            </button>
                            <button class="btn btn-success btn-action"
                                    x-show="chiTiet.status === 'Đang nấu'"
                                    @click="finishCooking(chiTiet.id)">
                                <i class="fas fa-check me-1"></i>Hoàn thành nấu
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </template>
        <div class="col-12" x-show="listChiTietBan.length === 0">
            <div class="alert alert-info text-center">Không có món nào cần làm.</div>
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
                    return await response.json();
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