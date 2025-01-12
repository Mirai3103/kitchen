<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.prj.restaurant_kitchen.entities.MenuItem" %>
<%@ page import="com.prj.restaurant_kitchen.entities.Phong" %>
<%@ page import="com.prj.restaurant_kitchen.entities.Ban" %>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Management</title>
    
</head>
<body>
    <div class="header">
        <button id="roomTableButton" onclick="toggleView('roomTable')">Phòng bàn</button>
        <button id="menuButton" onclick="toggleView('menu')">Thực đơn</button>
        <div class="search-bar">
            <input type="text" placeholder="Search...">
            <button>🔍</button>
        </div>
        <div id="currentLocation">Phòng 1 | Bàn 6</div>
    </div>

    <div class="category-nav">
        <button>Tất cả</button>
        <button>Khai vị</button>
        <button>Gỏi</button>
        <button>Cơm</button>
        <button>Lẩu</button>
        <button>Món chính</button>
        <button>Món phụ</button>
        <button>Tráng miệng</button>
        <button>Đồ uống</button>
        <button>Combo</button>
    </div>

    <div class="main-container">
    
<!-- menu -->
        <div id="menuView" class="menu-grid">
            <%
            List<MenuItem> menuItems = (List<MenuItem>)request.getAttribute("menuItems");
            for (MenuItem item : menuItems) {
            %>
                <div class="menu-item" onclick="console.log('<%= item.getId() %>', '<%= item.getTenMon() %>', '<%= item.getGia() %>'); addToOrder('<%= item.getId() %>', '<%= item.getTenMon() %>', '<%= item.getGia() %>')">
                    <img src="images/<%= item.getHinhAnh() %>">
                    <div class="menu-item-details">
                        <div><%= item.getTenMon() %></div>
					<div class="menu-item-price"><%=String.format("%,.0f", item.getGia())%>
						VND
					</div>
				</div>
                </div>
            <%
            }
            %>
        </div>
        
<!-- room -->
        <div id="roomTableView" class="room-grid" style="display: none;">
           </div>
<!-- bill -->
        <div class="order-panel">
            <div class="order-header">
                <h2>Hóa Đơn</h2>
            </div>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Tên món</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody id="orderItems">
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td colspan="3">Tổng tiền:</td>
                        <td id="totalAmount">0 VND</td>
                    </tr>
                </tfoot>
            </table>
            <div class="action-buttons">
                <button class="btn-print">IN</button>
                <button class="btn-notify">THÔNG BÁO</button>
                <button class="btn-pay" onclick="submitOrder()">THANH TOÁN</button>
            </div>
        </div>
    </div>

    <script>
        function toggleView(view) {
            const menuView = document.getElementById('menuView');
            const roomTableView = document.getElementById('roomTableView');
            const menuButton = document.getElementById('menuButton');
            const roomTableButton = document.getElementById('roomTableButton');

            if (view === 'menu') {
                menuView.style.display = 'grid';
                roomTableView.style.display = 'none';
                menuButton.style.fontWeight = 'bold';
                roomTableButton.style.fontWeight = 'normal';
            } else {
                menuView.style.display = 'none';
                roomTableView.style.display = 'grid';
                menuButton.style.fontWeight = 'normal';
                roomTableButton.style.fontWeight = 'bold';
            }
        }

        function selectTable(roomName, tableName) {
            document.getElementById('currentLocation').textContent = `${roomName} | ${tableName}`;
            // Here you can add logic to update the current order with the selected room and table
        }

        let currentOrder = { idPhong: null, idBan: null, items: [] };

        function addToOrder(idMon, tenMon, gia) {
            console.log('Tên món:', tenMon, 'Giá:', gia);
            const existingItem = currentOrder.items.find(item => item.idMon === idMon);
            if (existingItem) {
                existingItem.soLuong++;
            } else {
                currentOrder.items.push({ idMon, tenMon, soLuong: 1, donGia: gia });
            }
            console.log("Updated Order Items:", currentOrder.items);
            updateOrderSummary();
        }

        function updateOrderSummary() {
            console.log("Current Order Items:", currentOrder.items);
            const orderItems = document.getElementById('orderItems');
            orderItems.innerHTML = '';
            let total = 0;

            for (let i = 0; i < currentOrder.items.length; i++) {
                const item = currentOrder.items[i];
                const itemTotal = item.soLuong * item.donGia;
                total += itemTotal;

                orderItems.innerHTML += `
                    <tr>
                        <td>${item.tenMon}</td>
                        <td>
                            <div class="quantity-control">
                                <button onclick="updateQuantity(${item.idMon}, ${item.soLuong - 1})">-</button>
                                <span>${item.soLuong}</span>
                                <button onclick="updateQuantity(${item.idMon}, ${item.soLuong + 1})">+</button>
                            </div>
                        </td>
                        <td>${item.donGia.toLocaleString()} VND</td>
                        <td>${itemTotal.toLocaleString()} VND</td>
                    </tr>
                `;
            }


            document.getElementById('totalAmount').textContent = `${total.toLocaleString()} VND`;
        }

        function updateQuantity(idMon, newQuantity) {
            console.log("Updating quantity for ID:", idMon, "New Quantity:", newQuantity);

            if (typeof idMon === 'undefined' || idMon === null) {
                console.error("Invalid ID in updateQuantity:", idMon);
                return;
            }

            const item = currentOrder.items.find(item => item.idMon == idMon);
            if (!item) {
                console.error("Item not found for ID:", idMon);
                return;
            }

            if (newQuantity > 0) {
                item.soLuong = newQuantity;
            } else {
                currentOrder.items = currentOrder.items.filter(i => i.idMon != idMon);
            }

            console.log("Updated Order Items after quantity change:", currentOrder.items);
            updateOrderSummary();
        }




        function submitOrder() {
            if (currentOrder.items.length === 0) {
                alert('Please add items to your order');
                return;
            }

            currentOrder.items.forEach(item => {
                const orderData = {
                    idPhong: currentOrder.idPhong,
                    idBan: currentOrder.idBan,
                    idMon: item.idMon,
                    soLuong: item.soLuong,
                    donGia: item.donGia
                };

                fetch('/createOrder', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(orderData)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        console.log('Order item submitted successfully');
                    } else {
                        console.error('Error submitting order item');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            });

            alert('Order submitted successfully!');
            currentOrder.items = [];
            updateOrderSummary();
        }
    </script>
</body>


<style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
        }

        .header {
            background-color: #1a237e;
            color: white;
            padding: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background: white;
            border-radius: 20px;
            padding: 5px 15px;
            flex: 1;
            max-width: 400px;
        }

        .search-bar input {
            border: none;
            outline: none;
            padding: 5px;
            width: 100%;
        }

        .category-nav {
            background-color: #f0f0f0;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            display: flex;
            gap: 15px;
            overflow-x: auto;
        }

        .category-nav button {
            border: none;
            background: none;
            padding: 5px 10px;
            cursor: pointer;
            white-space: nowrap;
        }

        .category-nav button:hover {
            color: #1a237e;
        }

        .main-container {
            display: flex;
            justify-content: space-between;
            height: calc(100vh - 100px);
        }

        .menu-grid {
            flex: 1;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 20px;
            padding: 20px;
            overflow-y: auto;
        }

        .menu-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            text-align: center;
        }

        .menu-item img {
            width: 100%;
            height: 120px;
            object-fit: cover;
        }

        .menu-item-details {
            padding: 10px;
        }

        .menu-item-price {
            color: #1a237e;
            font-weight: bold;
        }

        .order-panel {
            width: 400px;
            background: white;
            border-left: 1px solid #ddd;
            display: flex;
            flex-direction: column;
        }

        .order-header {
            padding: 15px;
            background: #f5f5f5;
            border-bottom: 1px solid #ddd;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-table th {
            background: #f5f5f5;
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .order-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-control button {
            width: 24px;
            height: 24px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 4px;
            cursor: pointer;
        }

        .total-row {
            font-weight: bold;
            background: #f5f5f5;
        }

        .action-buttons {
            padding: 15px;
            display: flex;
            gap: 10px;
            margin-top: auto;
        }

        .action-buttons button {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-print {
            background: #424242;
            color: white;
        }

        .btn-notify {
            background: #e91e63;
            color: white;
        }

        .btn-pay {
            background: #4caf50;
            color: white;
        }

        /* New styles for room and table view */
        .room-grid {
            flex: 1;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
            overflow-y: auto;
        }

        .room-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
        }

        .room-title {
            background-color: #f5f5f5;
            padding: 10px;
            font-weight: bold;
            border-bottom: 1px solid #ddd;
        }

        .table-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            padding: 10px;
        }

        .table-button {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
            cursor: pointer;
        }

        .table-button.occupied {
            background-color: #ffcdd2;
            color: #c62828;
        }
    </style>
</html>