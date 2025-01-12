<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.prj.restaurant_kitchen.entities.MenuItem"%>
<%@ page import="com.prj.restaurant_kitchen.entities.BookParty"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>The Sea Restaurant - Menu</title>

</head>
<body>

    <!-- Navigation -->
    <div class="nav-container">
        <div class="logo">The Sea Restaurant</div>
        <div class="main-nav">
            <a href="#">TRANG CHỦ</a>
            <div class="dropdown">
                <a href="#" class="menu-link">MENU</a>
                <div class="dropdown-content">
                    <a href="#">Món chính</a>
                    <a href="#">Món phụ</a>
                    <a href="#">Khai vị</a>
                    <a href="#">Tráng miệng</a>
                    <a href="#">Lẩu</a>
                    <a href="#">Combo</a>
                    <a href="#">Đồ uống</a>
                    <a href="#">Gỏi</a>
                </div>
            </div>
            <div class="dropdown">
                <a href="#" class="menu-link">ĐẶT TIỆC</a>
                <div class="dropdown-content">
                    <a href="#">Hội thảo Công ty</a>
                    <a href="#">Sinh nhật</a>
                    <a href="#">Tiệc cưới</a>
                    <a href="#">Hẹn hò</a>                    
                    <a href="#">Lễ khai trương</a>
                </div>
            </div>
            <a href="#">LIÊN HỆ</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Menu Content -->
        <div class="menu-content">
            <div class="category-title">Món Ăn</div>
            <div class="menu-grid">
                <%
                    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
                    if (menuItems == null || menuItems.isEmpty()) {
                %>
                    <div class="no-data">No menu items available. Please check back later!</div>
                <%
                    } else {
                        for (MenuItem item : menuItems) {
                %>
				<div class="menu-item">
					<img src="images/<%=item.getHinhAnh()%>"
						alt="<%=item.getTenMon()%>">
					<h3><%=item.getTenMon()%></h3>
					<p><%=item.getGia()%>
						VND
					</p>
					<div class="menu-actions">
						<button class="btn-details">Xem chi tiết</button>
						<button class="btn-order">Đặt món</button>
					</div>
				</div>

				<%
				}
				}
				%>
            </div>
            
            <div class="category-title">Không gian tại The Sea</div>
            <div class="menu-grid">
                <%
                    List<BookParty> parties = (List<BookParty>) request.getAttribute("parties");
                    if (parties == null || parties.isEmpty()) {
                %>
                    <div class="no-data">No menu items available. Please check back later!</div>
                <%
                    } else {
                        for (BookParty party : parties) {
                %>
				<div class="menu-item">
					<img src="images/<%=party.getHinhAnh()%>"
						alt="<%=party.getTen()%>">
					<h3><%=party.getTen()%></h3>
					<div class="menu-actions">
						<button class="btn-details">Xem chi tiết</button>
					</div>
				</div>

				<%
				}
				}
				%>
            </div>
        </div>
    </div>

   <!-- Shopping Cart Icon -->
<div class="cart-icon" onclick="showModal()">
    🛒 <span id="cartCount">0</span>
</div>

<!-- Add Cart Modal -->
<div id="cartModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <div class="success-message">
                <span class="checkmark">✓</span>
                Bạn đã thêm sản phẩm vào giỏ hàng thành công!
            </div>
            <span class="close">&times;</span>
        </div>
        
        <div class="cart-items">
            <h3>Giỏ hàng của bạn có <span id="itemCount">0</span> sản phẩm</h3>
            
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody id="cartItems">
                    <!-- Cart items will be dynamically added here -->
                </tbody>
            </table>
            
            <div class="cart-total">
                <span>Tổng tiền thanh toán:</span>
                <span id="totalAmount">0₫</span>
            </div>
            
            <div class="cart-actions">
                <button class="checkout-btn"><a href="<%=request.getContextPath()%>/order">Thực hiện thanh toán</a></button>
                <button class="continue-shopping">Tiếp tục mua hàng</button>
            </div>
        </div>
    </div>
</div>
</body>

<script>
let cart = [];

function addToCart(id, name, price, image) {
    let existingItem = null;
    for (let i = 0; i < cart.length; i++) {
        if (cart[i].id === id) {
            existingItem = cart[i];
            break;
        }
    }
    
    if (existingItem) {
        existingItem.quantity += 1;
    } else {
        cart.push({
            id: id,
            name: name,
            price: price,
            image: image,
            quantity: 1
        });
    }
    
    updateCartModal();
    updateCartCount();
    showModal();
}

function updateCartCount() {
    let totalQuantity = 0;
    for (let i = 0; i < cart.length; i++) {
        totalQuantity += cart[i].quantity;
    }
    document.getElementById('cartCount').textContent = totalQuantity;
}

function updateCartModal() {
    const cartItems = document.getElementById('cartItems');
    const itemCount = document.getElementById('itemCount');
    const totalAmount = document.getElementById('totalAmount');
    
    cartItems.innerHTML = '';
    let total = 0;
    
    for (let i = 0; i < cart.length; i++) {
        const item = cart[i];
        const subtotal = item.price * item.quantity;
        total += subtotal;
        
        cartItems.innerHTML += `
            <tr>
                <td>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <img src="${item.image}" alt="${item.name}">
                        <div>
                            <div>${item.name}</div>
                            <a class="remove-item" onclick="removeItem(${item.id})">Xóa sản phẩm</a>
                        </div>
                    </div>
                </td>
                <td>${item.price.toLocaleString()}₫</td>
                <td>
                    <div class="quantity-controls">
                        <button onclick="updateQuantity(${item.id}, -1)">-</button>
                        <input type="text" value="${item.quantity}" readonly>
                        <button onclick="updateQuantity(${item.id}, 1)">+</button>
                    </div>
                </td>
                <td>${subtotal.toLocaleString()}₫</td>
            </tr>
        `;
    }
    
    itemCount.textContent = cart.length;
    totalAmount.textContent = total.toLocaleString() + '₫';
}

function updateQuantity(id, change) {
    for (let i = 0; i < cart.length; i++) {
        if (cart[i].id === id) {
            cart[i].quantity = Math.max(1, cart[i].quantity + change);
            break;
        }
    }
    updateCartModal();
    updateCartCount();
}

function removeItem(id) {
    cart = cart.filter(function(item) {
        return item.id !== id;
    });
    updateCartModal();
    updateCartCount();
}

function showModal() {
    document.getElementById('cartModal').style.display = 'block';
}

function hideModal() {
    document.getElementById('cartModal').style.display = 'none';
}

// Event Listeners
document.querySelector('.close').addEventListener('click', hideModal);
document.querySelector('.continue-shopping').addEventListener('click', hideModal);

// Close modal when clicking outside
window.addEventListener('click', function(event) {
    const modal = document.getElementById('cartModal');
    if (event.target === modal) {
        hideModal();
    }
});

// Update the menu-item buttons to use addToCart
document.addEventListener('DOMContentLoaded', function() {
    var orderButtons = document.querySelectorAll('.btn-order');
    for (var i = 0; i < orderButtons.length; i++) {
        orderButtons[i].addEventListener('click', function(e) {
            var menuItem = e.target.closest('.menu-item');
            var name = menuItem.querySelector('h3').textContent;
            var priceText = menuItem.querySelector('p').textContent;
            var price = parseInt(priceText.replace(/[^\d]/g, ''));
            var image = menuItem.querySelector('img').src;
            var id = Date.now(); // Using timestamp as temporary ID
            
            addToCart(id, name, price, image);
        });
    }
});
</script>

    <style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f0f0f0;
}

/* Top Search Bar */
.search-bar {
	background-color: #1a4b72;
	padding: 10px 0;
	text-align: center;
}

.search-bar input {
	width: 300px;
	padding: 8px;
	border-radius: 20px;
	border: none;
	background-color: #2c5d84;
	color: white;
}

.search-bar input::placeholder {
	color: #fff;
	opacity: 0.7;
}

/* Navigation */
.nav-container {
	background-color: rgba(128, 128, 128, 0.8);
	padding: 15px 0;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo {
	margin-left: 20px;
	color: white;
	font-style: italic;
	font-size: 24px;
}

.main-nav {
	display: flex;
	gap: 30px;
	margin-right: 20px;
}

.main-nav a {
	color: white;
	text-decoration: none;
	font-weight: bold;
}

/* Main Container */
.container {
	display: flex;
	max-width: 1200px;
	margin: 20px auto;
	background-color: white;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Sidebar */
.sidebar {
	width: 250px;
	padding: 20px;
	border-right: 1px solid #ddd;
}

.sidebar h3 {
	color: #333;
	margin-bottom: 15px;
}

.sidebar input[type="text"] {
	width: 100%;
	padding: 8px;
	margin-bottom: 15px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.sidebar .filter-section {
	margin-bottom: 20px;
}

.sidebar label {
	display: block;
	margin-bottom: 8px;
}

/* Menu Grid */
.menu-content {
	flex: 1;
	padding: 20px;
}

.category-title {
	background-color: #87CEEB;
	color: white;
	padding: 10px;
	margin-bottom: 20px;
}

.menu-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	gap: 20px;
}

.menu-item {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
	transition: transform 0.2s;
}

.menu-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.menu-item img {
	width: 100%;
	height: 150px;
	object-fit: cover;
	margin-bottom: 10px;
}

.menu-item h3 {
	color: #333;
	margin: 10px 0;
}

.menu-item p {
	color: #4CAF50;
	font-weight: bold;
}

/* Shopping Cart Icon */
.cart-icon {
	position: fixed;
	top: 100px;
	right: 20px;
	background-color: white;
	padding: 10px;
	border-radius: 50%;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.no-data {
	text-align: center;
	font-size: 18px;
	color: #555;
	margin-top: 20px;
	grid-column: 1/-1;
}

/* Menu Item Actions */
.menu-item {
	position: relative;
	overflow: hidden;
}

.menu-actions {
	position: absolute;
	bottom: 0;
	left: 0;
	right: 0;
	background-color: rgba(0, 0, 0, 0.6);
	display: flex;
	justify-content: space-around;
	align-items: center;
	padding: 10px 0;
	opacity: 0;
	transition: opacity 0.3s ease;
}

.menu-actions button {
	background-color: white;
	color: black;
	border: none;
	padding: 8px 15px;
	font-size: 14px;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.menu-actions button:hover {
	background-color: #87CEEB;
	color: white;
}

.menu-item:hover .menu-actions {
	opacity: 1;
}


<style>
        /* Previous CSS styles remain the same */

        /* Add new styles for dropdown */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 200px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 4px;
            margin-top: 5px;
        }

        .dropdown-content a {
            color: #333 !important;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s;
        }

        .dropdown-content a:hover {
            background-color: #87CEEB;
            color: white !important;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .menu-link::after {
            content: '▼';
            margin-left: 5px;
            font-size: 12px;
        }

        /* Update existing nav styles */
        .main-nav {
            display: flex;
            gap: 30px;
            margin-right: 20px;
            align-items: center;
        }

        .main-nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 5px 0;
        }

/* Cart icon styles */
.cart-icon {
    position: fixed;
    top: 100px;
    right: 20px;
    background-color: white;
    padding: 10px 15px;
    border-radius: 50%;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    cursor: pointer;
    z-index: 999;
}

#cartCount {
    background-color: #ff0000;
    color: white;
    border-radius: 50%;
    padding: 2px 6px;
    font-size: 12px;
    position: absolute;
    top: -5px;
    right: -5px;
}

/* Modal styles */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1000;
}

.modal-content {
    background-color: white;
    margin: 50px auto;
    width: 90%;
    max-width: 800px;
    border-radius: 8px;
    position: relative;
}

.modal-header {
    padding: 15px;
    border-bottom: 1px solid #eee;
}

.success-message {
    background-color: #ff0000;
    color: white;
    padding: 10px;
    border-radius: 4px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.checkmark {
    background-color: white;
    color: #ff0000;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
}

.close {
    position: absolute;
    right: 15px;
    top: 15px;
    font-size: 24px;
    cursor: pointer;
    color: white;
}

.cart-items {
    padding: 20px;
}

.cart-table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
}

.cart-table th,
.cart-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

.cart-table img {
    width: 80px;
    height: 80px;
    object-fit: cover;
}

.quantity-controls {
    display: flex;
    align-items: center;
    gap: 10px;
}

.quantity-controls button {
    width: 30px;
    height: 30px;
    border: 1px solid #ddd;
    background: white;
    cursor: pointer;
}

.quantity-controls input {
    width: 50px;
    text-align: center;
    border: 1px solid #ddd;
    padding: 5px;
}

.cart-total {
    text-align: right;
    font-size: 18px;
    font-weight: bold;
    margin: 20px 0;
}

.cart-actions {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
}

.checkout-btn {
    background-color: #ff0000;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 4px;
    cursor: pointer;
}

.continue-shopping {
    background-color: #fff;
    color: #ff0000;
    border: 1px solid #ff0000;
    padding: 12px 24px;
    border-radius: 4px;
    cursor: pointer;
}

.remove-item {
    color: #666;
    text-decoration: underline;
    cursor: pointer;
}
</style>
</html>