<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.prj.restaurant_kitchen.entities.Customer"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Management</title>
</head>
<body>
    <h2>Customer Management</h2>

    <!-- Form tìm kiếm -->
    <form action="customer" method="get">
        <input type="text" name="search" placeholder="Search by name or email" />
        <button type="submit">Search</button>
    </form>

    <br>

    <!-- Hiển thị danh sách khách hàng -->
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                if (customers != null && !customers.isEmpty()) {
                    for (Customer customer : customers) {
            %>
            <tr>
                <td><%= customer.getId() %></td>
                <td><%= customer.getEmail() %></td>
                <td><%= customer.getHoTen() %></td>
                <td><%= customer.getPhone() %></td>
                <td><%= customer.getDiaChi() %></td>
                <td>
                    <a href="edit?id=<%= customer.getId() %>">Edit</a> | 
                    <a href="delete?id=<%= customer.getId() %>">Delete</a>
                </td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr><td colspan="6">No customers found</td></tr>
            <% 
                }
            %>
        </tbody>
    </table>
</body>
</html>
