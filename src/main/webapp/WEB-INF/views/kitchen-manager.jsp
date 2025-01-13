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
    <!-- Alpine.js -->
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <style>
        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-5" x-data="orderData()">
        <div class="d-flex justify-content-between">
            <h2 class="mb-4">Danh sách món cần làm</h2>
            <a href="/home">Quay lại</a>
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
                    <th>Đặt lúc</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody id="orderTableBody">
                <template x-for="chiTiet in listChiTietBan" :key="chiTiet.id">
                    <tr>
                        <td x-text="chiTiet.id"></td>
                        <td x-text="chiTiet.ban.tenBan + ' - ' + chiTiet.phong.tenPhong"></td>
                        <td x-text="chiTiet.mon.tenMon"></td>
                        <td x-text="chiTiet.soLuong"></td>
                        <td x-text="formatCurrency(chiTiet.donGia)"></td>
                        <td x-text="formatCurrency(chiTiet.thanhTien)"></td>
                        <td x-text="formatDate(chiTiet.createdAt)"></td>
                        <td x-text="chiTiet.status"></td>
                        <td>
                            <button class="btn btn-sm btn-info me-1"
                                @click="viewIngredients(chiTiet.mon.id)">
                                Xem nguyên liệu
                            </button>
                            <button class="btn btn-sm btn-primary" 
                                x-show="chiTiet.status === 'Đang xử lý'"
                                @click="startCooking(chiTiet.id)">
                                Nhận món
                            </button>
                            <button class="btn btn-sm btn-success"
                                x-show="chiTiet.status === 'Đang nấu'"
                                @click="finishCooking(chiTiet.id)">
                                Hoàn thành nấu
                            </button>
                            <button class="btn btn-sm btn-danger"
                                x-show="chiTiet.status === 'Đợi phục vụ'"
                                @click="served(chiTiet.id)">
                                Hoàn thành phục vụ
                            </button>
                        </td>
                    </tr>
                </template>
                <tr x-show="listChiTietBan.length === 0">
                    <td colspan="9" class="text-center">Không có món nào cần làm.</td>
                </tr>
            </tbody>
        </table>

        <!-- Ingredients Modal -->
        <div class="modal fade" id="ingredientsModal" tabindex="-1" aria-labelledby="ingredientsModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ingredientsModalLabel">Danh sách nguyên liệu</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table">
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

    <!-- Bootstrap JS and Popper.js -->
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
                    const response = await fetch(`/api/order/start-cooking/${id}`, {
                        method: 'PUT'
                    });
                    if (response.ok) {
                        this.updateOrderStatus(id, 'Đang nấu');
                    }
                },
                async finishCooking(id) {
                    const response = await fetch(`/api/order/finish-cooking/${id}`, {
                        method: 'PUT'
                    });
                    if (response.ok) {
                        this.updateOrderStatus(id, 'Đợi phục vụ');
                    }
                },
                async served(id) {
                    const response = await fetch(`/api/order/served/${id}`, {
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