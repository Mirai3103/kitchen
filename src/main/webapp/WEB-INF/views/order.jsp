<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng - The Sea</title>
</head>
<body>
    <div class="container">
        <div class="order-form">
            <h2>Thông tin mua hàng</h2>
            <form action="order" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email">
                </div>

                <div class="form-group">
                    <label for="fullName">Họ và tên</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>

                <div class="form-group">
                    <label for="phone">Số điện thoại</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>

                <div class="form-group">
                    <label for="address">Địa chỉ</label>
                    <input type="text" id="address" name="address" required>
                </div>

                <div class="form-group">
                    <label for="province">Tỉnh thành</label>
                    <select id="province" name="province" required>
                        <option value="">Chọn tỉnh thành</option>
                        <!-- Add provinces dynamically -->
                    </select>
                </div>

                <div class="form-group">
                    <label for="district">Quận huyện</label>
                    <select id="district" name="district" required>
                        <option value="">Chọn quận huyện</option>
                        <!-- Add districts dynamically -->
                    </select>
                </div>

                <div class="form-group">
                    <label for="ward">Phường xã</label>
                    <select id="ward" name="ward" required>
                        <option value="">Chọn phường xã</option>
                        <!-- Add wards dynamically -->
                    </select>
                </div>

                <div class="form-group">
                    <label for="notes">Ghi chú (tùy chọn)</label>
                    <textarea id="notes" name="notes" rows="3"></textarea>
                </div>

                <h2>Vận chuyển</h2>
                <div class="delivery-info">
                    <p>Vui lòng nhập thông tin giao hàng</p>
                </div>

                <h2>Thanh toán</h2>
                <div class="payment-methods">
                    <div class="payment-method">
                        <input type="radio" id="vnpay" name="paymentMethod" value="VNPAY-QR" required>
                        <label for="vnpay">
                            <img src="images/vnpay.png" alt="VNPAY-QR">
                            Thanh toán qua VNPAY-QR
                        </label>
                    </div>
                    <div class="payment-method">
                        <input type="radio" id="cod" name="paymentMethod" value="COD" required>
                        <label for="cod">
                            <img src="images/cod.png" alt="COD">
                            Nhận món ăn rồi thanh toán (COD)
                        </label>
                    </div>
                </div>
            </form>
        </div>

        <div class="order-summary">
            <h2>Đơn hàng (2 sản phẩm)</h2>
            <div class="cart-items">
                <% 
                // This would typically come from your cart in session
                String[] items = (String[])session.getAttribute("cartItems");
                if (items != null) {
                    for (String item : items) {
                %>
                <div class="cart-item">
                    <img src="images/product.jpg" alt="Product">
                    <div class="cart-item-details">
                        <div class="cart-item-name"><%=item%></div>
                        <div class="cart-item-quantity">x1</div>
                    </div>
                    <div class="cart-item-price">150.000₫</div>
                </div>
                <%
                    }
                }
                %>
            </div>

            <div class="discount-code">
                <input type="text" placeholder="Nhập mã giảm giá">
                <button>Áp dụng</button>
            </div>

            <div class="cart-total">
                <div class="cart-total-row">
                    <span>Tạm tính</span>
                    <span>300.000₫</span>
                </div>
                <div class="cart-total-row">
                    <span>Phí vận chuyển</span>
                    <span>-</span>
                </div>
                <div class="cart-total-row">
                    <strong>Tổng cộng</strong>
                    <strong>300.000₫</strong>
                </div>
            </div>

            <button class="order-button">ĐẶT HÀNG</button>
        </div>
    </div>

    <script>
        // Add event listeners for province/district/ward selectors
        document.getElementById('province').addEventListener('change', function() {
            // Update districts based on selected province
            updateDistricts();
        });

        document.getElementById('district').addEventListener('change', function() {
            // Update wards based on selected district
            updateWards();
        });

        function updateDistricts() {
            // Add logic to update districts
        }

        function updateWards() {
            // Add logic to update wards
        }

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const phone = document.getElementById('phone').value;
            const phoneRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/;
            
            if (!phoneRegex.test(phone)) {
                e.preventDefault();
                alert('Số điện thoại không hợp lệ!');
            }
        });
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
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            gap: 20px;
        }

        .order-form {
            flex: 2;
            background: white;
            padding: 20px;
            border-radius: 8px;
        }

        .order-summary {
            flex: 1;
            background: #e1dfdf;
            padding: 20px;
            border-radius: 8px;
            height: fit-content;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input, 
        .form-group select, 
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .payment-methods {
            margin: 20px 0;
        }

        .payment-method {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cart-item {
            display: flex;
            gap: 10px;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .cart-item img {
            width: 60px;
            height: 60px;
            object-fit: cover;
        }

        .cart-item-details {
            flex: 1;
        }

        .cart-item-quantity {
            color: #666;
        }

        .cart-total {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .cart-total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .discount-code {
            display: flex;
            gap: 10px;
            margin: 20px 0;
        }

        .discount-code input {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .discount-code button {
            padding: 8px 15px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .order-button {
            width: 100%;
            padding: 15px;
            background: #1d7853;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }

        .order-button:hover {
            background: #cc0000;
        }
    </style>
</html>