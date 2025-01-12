<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Order</title>
    <script>
        async function createOrder() {
            const idBan = document.getElementById("idBan").value;
            const tenMon = document.getElementById("tenMon").value;
            const soLuong = document.getElementById("soLuong").value;
            const donGia = document.getElementById("donGia").value;

            const orderData = {
                idBan: idBan,
                tenMon: tenMon,
                soLuong: parseInt(soLuong),
                donGia: parseFloat(donGia)
            };

            try {
                const response = await fetch('/createOrder', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(orderData)
                });

                const result = await response.json();

                if (result.status === "success") {
                    alert("Order created successfully!");
                } else {
                    alert("Error creating order: " + (result.message || "Unknown error"));
                }
            } catch (error) {
                alert("Failed to create order: " + error.message);
            }
        }
    </script>
</head>
<body>
    <h1>Create Order</h1>
    <form id="orderForm" onsubmit="event.preventDefault(); createOrder();">
        <label for="idBan">Table ID (idBan):</label><br>
        <input type="text" id="idBan" name="idBan" required><br><br>

        <label for="tenMon">Dish Name (tenMon):</label><br>
        <input type="text" id="tenMon" name="tenMon" required><br><br>

        <label for="soLuong">Quantity (soLuong):</label><br>
        <input type="number" id="soLuong" name="soLuong" required><br><br>

        <label for="donGia">Price (donGia):</label><br>
        <input type="number" step="0.01" id="donGia" name="donGia" required><br><br>

        <button type="submit">Create Order</button>
    </form>
</body>
</html>
