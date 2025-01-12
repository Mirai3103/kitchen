<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.prj.restaurant_kitchen.entities.Employee" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        form {
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <h1>Employee Management</h1>

    <!-- Hiển thị trạng thái -->
    <%
        String status = (String) request.getAttribute("status");
        if (status != null) {
            if ("invalid_data".equals(status)) {
    %>
                <p style="color: red;">Invalid data. Please check your inputs.</p>
    <%
            } else if ("invalid_id".equals(status)) {
    %>
                <p style="color: red;">Invalid ID. Please check the selected employee.</p>
    <%
            } else if ("failure".equals(status)) {
    %>
                <p style="color: red;">Operation failed. Please try again.</p>
    <%
            } else if ("invalid_search".equals(status)) {
    %>
                <p style="color: red;">Invalid search term. Please enter a valid username.</p>
    <%
            }
        }
    %>

    <!-- Form tìm kiếm -->
    <form method="get" action="employee">
        <input type="hidden" name="action" value="search">
        <label for="user_name">Search by Username:</label>
        <input type="text" id="user_name" name="user_name" placeholder="Enter username">
        <button type="submit">Search</button>
    </form>

    <!-- Hiển thị danh sách nhân viên -->
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Username</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Employee> users = (List<Employee>) request.getAttribute("users");
                if (users != null && !users.isEmpty()) {
                    for (Employee user : users) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getFirstName() %></td>
                <td><%= user.getLastName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getUserName() %></td>
                <td><%= user.getQuyen() %></td>
                <td>
                    <!-- Form xóa -->
                    <form action="employee" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= user.getId() %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7">No employees found.</td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <!-- Form thêm mới nhân viên -->
    <h2>Add New Employee</h2>
    <form action="employee" method="post">
        <input type="hidden" name="action" value="add">
        <div>
            <label for="first_name">First Name:</label>
            <input type="text" id="first_name" name="first_name" required>
        </div>
        <div>
            <label for="last_name">Last Name:</label>
            <input type="text" id="last_name" name="last_name" required>
        </div>
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <label for="user_name">Username:</label>
            <input type="text" id="user_name" name="user_name" required>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <label for="quyen">Role:</label>
            <input type="text" id="quyen" name="quyen" required>
        </div>
        <button type="submit">Add Employee</button>
    </form>
</body>
</html>
