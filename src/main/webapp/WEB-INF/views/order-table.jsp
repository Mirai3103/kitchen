<%@ page import="com.prj.restaurant_kitchen.entities.Ban"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bàn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="//unpkg.com/alpinejs" defer></script>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .table-card {
            width: 180px;
            height: 180px;
            border: 2px solid #007bff;
            border-radius: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .table-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 123, 255, 0.3);
        }
        .table-card.occupied {
            border-color: #dc3545;
            background-color: #fff5f5;
        }
        .table-status {
            font-size: 0.9rem;
            margin-top: 10px;
            padding: 5px 10px;
            border-radius: 20px;
        }
        .back-link {
            text-decoration: none;
            color: #6c757d;
            transition: color 0.3s ease;
            font-weight: 600;
        }
        .back-link:hover {
            color: #343a40;
        }
        .notification-badge {
            font-size: 0.7rem;
            padding: 0.25em 0.6em;
        }
        .table-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container mt-5" x-data="notiData()" x-init="init()">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="display-6 text-primary"><i class="fas fa-chair me-2"></i>Quản lý Bàn</h2>
        <a href="/home" class="back-link btn">
            <i class="fas fa-arrow-left me-2"></i>Quay lại Trang Chủ
        </a>
    </div>
    <div class="row g-4" x-data="tableData()" x-init="init()">
        <template x-for="table in tables" :key="table.id">
            <div class="col-6 col-md-4 col-lg-3 mb-4">
                <a :href="'datmon/' + table.id" class="text-decoration-none">
                    <div class="table-card position-relative"
                         :class="table.status === 'Trống' ? '' : 'occupied'">
                        <i class="fas fa-utensils table-icon" :class="table.status === 'Trống' ? 'text-success' : 'text-danger'"></i>
                        <h5 class="mb-2" x-text="table.tenBan"></h5>
                        <span class="table-status badge"
                              :class="table.status === 'Trống' ? 'bg-success' : 'bg-danger'"
                              x-text="table.status"></span>
                        <small class="mt-2 text-muted" x-text="table.phong.tenPhong"></small>
                        <span
                                :id="'notification-table-' + table.id"
                                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark notification-badge"
                                x-show="notiMapByTableId[table.id]?.length > 0"
                                x-text="notiMapByTableId[table.id]?.length || 0">
                            <span class="visually-hidden">unread messages</span>
                        </span>
                    </div>
                </a>
            </div>
        </template>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    function notiData() {
        return {
            notiMapByTableId: {},
            async fetchNoti() {
                try {
                    const response = await fetch('/api/notification?pageSize=1000');
                    const data = await response.json();
                    this.notiMapByTableId = data.reduce((acc, noti) => {
                        acc[noti.tableId] = [...(acc[noti.tableId] || []), noti];
                        return acc;
                    }, {});
                } catch (error) {
                    console.error('Error fetching notifications:', error);
                }
            },
            init() {
                this.fetchNoti();
                setInterval(() => {
                    this.fetchNoti();
                }, 3000);
            }
        }
    }

    function tableData() {
        return {
            tables: [],
            fetchTable() {
                fetch('/api/ban')
                    .then(response => response.json())
                    .then(data => {
                        this.tables = data;
                    })
                    .catch(error => {
                        console.error('Error fetching tables:', error);
                    });
            },
            init() {
                this.fetchTable();
                setInterval(() => {
                    this.fetchTable();
                }, 3000);
            }
        }
    }
</script>
</body>
</html>