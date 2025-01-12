<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.prj.restaurant_kitchen.entities.MenuItem"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý thực đơn</title>

</head>
<body>
	<h1>Quản lý thực đơn</h1>

	<!-- Nút thêm món ăn -->
	<button id="toggleAddMenuFormBtn">Thêm món ăn mới</button>

	<!-- Form thêm món ăn mới -->
	<div id="addMenuFormContainer" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<form id="addMenuForm" action="menu" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="action" value="add">

				<div class="form-group">
					<label for="ten_mon">Tên món:</label> <input type="text"
						id="ten_mon" name="ten_mon" required>
				</div>

				<div class="form-group">
					<label for="gia">Giá:</label> <input type="number" id="gia"
						name="gia" step="0.01" required>
				</div>

				<div class="form-group">
					<label for="mo_ta">Mô tả:</label>
					<textarea id="mo_ta" name="mo_ta"></textarea>
				</div>

				<div class="form-group">
					<label for="nguyen_lieu">Nguyên liệu:</label> <input type="text"
						id="nguyen_lieu" name="nguyen_lieu">
				</div>

				<div class="form-group">
					<label for="category">Phân loại:</label> <select id="category"
						name="category" required>
						<option value="">Chọn phân loại</option>
						<option value="mon_chinh">Món chính</option>
						<option value="mon_phu">Món phụ</option>
						<option value="trang_mieng">Tráng miệng</option>
						<option value="do_uong">Đồ uống</option>
						<option value="khai_vi">Khai vị</option>
						<option value="goi">Gỏi</option>
						<option value="combo">Combo</option>
						<option value="lau">Lẩu</option>

					</select>
				</div>
				<div>
					<label class="block text-sm font-medium text-gray-700">Hình
						ảnh:</label> <input type="file" name="hinh_anh"
						class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
				</div>

				<div class="form-actions">
					<button type="button" class="btn btn-cancel">
						<a href="<%=request.getContextPath()%>/menu">HỦY</a>
					</button>
					<button type="submit" class="btn btn-save">LƯU</button>
				</div>
			</form>
		</div>
	</div>

	<!-- Form update -->
	<!-- Form cập nhật món ăn -->
	<div id="updateMenuFormContainer" class="modal">
		<div class="modal-content">
			<span class="close update-close">&times;</span>
			<form id="updateMenuForm" action="menu" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="action" value="update"> <input
					type="hidden" id="update_id" name="id">

				<div class="form-group">
					<label for="update_ten_mon">Tên món:</label> <input type="text"
						id="update_ten_mon" name="ten_mon" required>
				</div>

				<div class="form-group">
					<label for="update_gia">Giá:</label> <input type="number"
						id="update_gia" name="gia" step="0.01" required>
				</div>

				<div class="form-group">
					<label for="update_mo_ta">Mô tả:</label>
					<textarea id="update_mo_ta" name="mo_ta"></textarea>
				</div>

				<div class="form-group">
					<label for="update_nguyen_lieu">Nguyên liệu:</label> <input
						type="text" id="update_nguyen_lieu" name="nguyen_lieu">
				</div>

				<div class="form-group">
					<label for="update_category">Phân loại:</label> 
					<select
						id="update_category" name="category" required>
						<option value="">Chọn phân loại</option>
						<option value="mon_chinh">Món chính</option>
						<option value="mon_phu">Món phụ</option>
						<option value="trang_mieng">Tráng miệng</option>
						<option value="do_uong">Đồ uống</option>
						<option value="khai_vi">Khai vị</option>
						<option value="goi">Gỏi</option>
						<option value="combo">Combo</option>
						<option value="lau">Lẩu</option>
					</select>
				</div>
				<div>
					<label class="block text-sm font-medium text-gray-700">Hình
						ảnh:</label> <input type="file" name="hinh_anh"
						class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
				</div>

				<div class="form-actions">
					<button type="button" class="btn btn-cancel update-cancel">Hủy</button>
					<button type="submit" class="btn btn-save">Cập nhật</button>
				</div>
			</form>
		</div>
	</div>



	<!-- Form tìm kiếm món ăn -->
	<form action="menu" method="GET">
		<input type="hidden" name="action" value="search"> <input
			type="text" name="ten_mon" placeholder="Tìm kiếm món ăn">
		<button type="submit">Tìm kiếm</button>
	</form>

	<!-- Nút ba gạch -->
	<div class="menu-toggle" onclick="toggleMenu()">&#9776;</div>
	<!-- Menu ẩn -->
	<div class="menu-container">
		<ul>
			<li><a href="<%=request.getContextPath()%>/home">Trang chủ</a></li>
			<li><a href="#">Đơn hàng</a></li>
			<li><a href="#">Khách hàng</a></li>
			<li><a href="#">Nhân viên</a></li>
			<li><a href="#">Nguyên liệu</a></li>
			<li><a href="#">Hóa đơn</a></li>
			<li><a href="#">Lương</a></li>
		</ul>
	</div>

	<!-- Hiển thị danh sách món ăn -->
	<table>
		<thead>
			<tr>
				<th>Tên món</th>
				<th>Giá</th>
				<th>Mô tả</th>
				<th>Nguyên liệu</th>
				<th>Hình ảnh</th>
				<th>Thao tác</th>
			</tr>
		</thead>
		<tbody>
			<%
			// Lấy đối tượng menuItems từ request
			Object menuItemsObj = request.getAttribute("menuItems");

			if (menuItemsObj  != null) {
				List<MenuItem> menuItems = (List<MenuItem>) menuItemsObj;

				if (menuItems != null && !menuItems.isEmpty()) {
					// Duyệt qua danh sách menuItems
					for (MenuItem item : menuItems) {
			%>
			<tr>
				<td><%=item.getTenMon()%></td>
				<td><%=item.getGia()%></td>
				<td><%=item.getMoTa()%></td>
				<td><%=item.getNguyenLieu()%></td>
				<td><img src="images/<%=item.getHinhAnh()%>"
					alt="<%=item.getTenMon()%>" width="100" height="100"></td>
				<td>
					<!-- Form xóa món -->
					<form action="menu" method="POST" style="display: inline;">
						<input type="hidden" name="action" value="delete"> <input
							type="hidden" name="id" value="<%=item.getId()%>">
						<button type="submit">Xóa</button>
					</form> <!-- Form sửa món -->
					<form action="menu" method="POST" style="display: inline;">
						<input type="hidden" name="action" value="update"> <input
							type="hidden" name="id" value="<%=item.getId()%>">
						<button type="button" class="update-btn"
							data-id="<%=item.getId()%>" data-ten-mon="<%=item.getTenMon()%>"
							data-gia="<%=item.getGia()%>" data-mo-ta="<%=item.getMoTa()%>"
							data-nguyen-lieu="<%=item.getNguyenLieu()%>"
							data-category="<%=item.getCategory()%>">Sửa</button>
					</form>
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="6">Không có món nào trong menu.</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="6">Không tìm thấy dữ liệu menu items.</td>
			</tr>
			<%
			}
			%>
		</tbody>

	</table>

	<script>
		document
				.getElementById('toggleAddMenuFormBtn')
				.addEventListener(
						'click',
						function() {
							document.getElementById('addMenuFormContainer').style.display = 'block';
						});

		document
				.querySelector('.close')
				.addEventListener(
						'click',
						function() {
							document.getElementById('addMenuFormContainer').style.display = 'none';
						});

		document
				.querySelector('.btn-cancel')
				.addEventListener(
						'click',
						function() {
							document.getElementById('addMenuFormContainer').style.display = 'none';
						});

		window
				.addEventListener(
						'click',
						function(event) {
							if (event.target == document
									.getElementById('addMenuFormContainer')) {
								document.getElementById('addMenuFormContainer').style.display = 'none';
							}
						});

		// Hiển thị modal cập nhật
		document
				.querySelectorAll('.update-btn')
				.forEach(
						function(btn) {
							btn
									.addEventListener(
											'click',
											function() {
												const id = this
														.getAttribute('data-id');
												const tenMon = this
														.getAttribute('data-ten-mon');
												const gia = this
														.getAttribute('data-gia');
												const moTa = this
														.getAttribute('data-mo-ta');
												const nguyenLieu = this
														.getAttribute('data-nguyen-lieu');
												const category = this
														.getAttribute('data-category');

												// Điền dữ liệu vào form
												document
														.getElementById('update_id').value = id;
												document
														.getElementById('update_ten_mon').value = tenMon;
												document
														.getElementById('update_gia').value = gia;
												document
														.getElementById('update_mo_ta').value = moTa;
												document
														.getElementById('update_nguyen_lieu').value = nguyenLieu;
												document
														.getElementById('update_category').value = category;

												// Hiển thị modal
												document
														.getElementById('updateMenuFormContainer').style.display = 'block';
											});
						});

		// Đóng modal cập nhật
		document
				.querySelector('.update-close')
				.addEventListener(
						'click',
						function() {
							document.getElementById('updateMenuFormContainer').style.display = 'none';
						});

		document
				.querySelector('.update-cancel')
				.addEventListener(
						'click',
						function() {
							document.getElementById('updateMenuFormContainer').style.display = 'none';
						});

		window
				.addEventListener(
						'click',
						function(event) {
							if (event.target == document
									.getElementById('updateMenuFormContainer')) {
								document
										.getElementById('updateMenuFormContainer').style.display = 'none';
							}
						});
	</script>
</body>

<style>
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	display: flex;
}

/* Sidebar Styles */
.menu-container {
	width: 200px;
	background-color: #87CEEB;
	min-height: 100vh;
	padding-top: 20px;
	position: fixed;
	left: 0;
	top: 0;
}

.menu-container ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.menu-container li {
	padding: 10px 20px;
}

.menu-container li a {
	color: #000;
	text-decoration: none;
	font-size: 14px;
}

.menu-container li:first-child {
	color: #ff0000;
	font-weight: bold;
}

/* Main Content Styles */
.container {
	margin-left: 200px;
	width: calc(100% - 200px);
	padding: 20px;
	background-color: #f5f5f5;
}

/* Search Bar Styles */
.search-container {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
	background: white;
	padding: 10px;
	border-radius: 4px;
}

.search-container input {
	flex: 1;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	margin-right: 10px;
}

#toggleAddMenuFormBtn {
	background-color: #45b3e0;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	cursor: pointer;
}

/* Table Styles */
table {
	width: 100%;
	border-collapse: collapse;
	background: white;
	border-radius: 4px;
	overflow: hidden;
}

th {
	background-color: #f8f9fa;
	padding: 12px;
	text-align: left;
	border-bottom: 2px solid #dee2e6;
}

td {
	padding: 12px;
	border-bottom: 1px solid #dee2e6;
}

/* Action Buttons */
td button {
	padding: 6px 12px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin: 0 4px;
}

td button[value="delete"] {
	background-color: #ff4444;
	color: white;
}

td button[value="update"] {
	background-color: #00C851;
	color: white;
}

/* Add Menu Form Styles */
.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #e6f3ff;
	margin: 10% auto;
	padding: 20px;
	border-radius: 8px;
	width: 80%;
	max-width: 500px;
	position: relative;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
}

.form-group input, .form-group textarea {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.form-actions {
	text-align: right;
	margin-top: 20px;
}

.btn {
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
}

.btn-cancel {
	background-color: #ff4444;
	color: white;
	margin-right: 10px;
}

.btn-save {
	background-color: #45b3e0;
	color: white;
}

.form-group select {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: white;
	font-size: 14px;
}

.form-group select:focus {
	outline: none;
	border-color: #45b3e0;
	box-shadow: 0 0 0 2px rgba(69, 179, 224, 0.2);
}

/* Image in table */
table img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 4px;
}

/* Menu Toggle Button */
.menu-toggle {
	display: none; /* Hidden by default as sidebar is always visible */
}

/* Responsive Design */
@media ( max-width : 768px) {
	.menu-container {
		transform: translateX(-100%);
		transition: transform 0.3s ease;
	}
	.menu-container.show {
		transform: translateX(0);
	}
	.menu-toggle {
		display: block;
		position: fixed;
		top: 10px;
		left: 10px;
		z-index: 1000;
		font-size: 24px;
		cursor: pointer;
	}
	.container {
		margin-left: 0;
		width: 100%;
	}
}
</style>
</html>