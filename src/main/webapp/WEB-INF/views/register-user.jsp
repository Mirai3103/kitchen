<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register User</title>
<script src="../resources/js/register-user.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



</head>

<body>
	<div class="container">
		<h1>Đăng kí</h1>
		<p>Nếu bạn chưa có tài khoản hãy điền theo mẫu dưới đây để đăng kí.</p>
		<form action="<%=request.getContextPath()%>/register" method="post"
			onsubmit="return validateRegister()" name="frm-register">

			<div class="form-group">
				<label for="firstName">Tên *</label>
				<input type="text" id="firstName" name="firstName" placeholder="Tên">
				<div id="firstNameError" class="error">* Bắt buộc</div>
			</div>

			<div class="form-group">
				<label for="lastName">Họ</label>
				<input type="text" id="lastName" name="lastName" placeholder="Họ">
				<div id="lastNameError" class="error"></div>
			</div>

			<div class="form-group">
				<label for="userName">Tên tài khoản *</label>
				<input type="text" id="userName" name="userName" placeholder="Tên tài khoản">
				<div id="userNameError" class="error"></div>
			</div>

			<div class="form-group">
				<label for="email">Email*</label>
				<input type="email" id="email" name="email" placeholder="Email*">
				<div id="emailError" class="error"></div>
			</div>

			<div class="form-group">
				<label for="password">Mật khẩu*</label>
				<input type="password" id="password" name="password" placeholder="Mật khẩu">
				<div id="passwordError" class="error"></div>
			</div>

			<div class="form-group">
				<label for="confirmPassword">Nhập lại mật khẩu *</label>
				<input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu">
				<div id="confirmPasswordError" class="error"></div>
			</div>

			<button type="submit" class="btn">Đăng ký</button>
			<a href="<%=request.getContextPath()%>/login" class="btn-link">hoặc Đăng nhập</a>
		</form>

		<div class="social-login">
				<!-- Link to Facebook -->
				<a href="https://www.facebook.com" target="_blank"
					title="Đăng kí với Facebook"> <img
					src="https://cdn-icons-png.flaticon.com/512/733/733547.png"
					alt="Facebook" width="48">
				</a>

				<!-- Link to Google -->
				<a href="https://accounts.google.com/signin" target="_blank"
					title="Đăng kí với Google"> <img
					src="https://cdn-icons-png.flaticon.com/512/300/300221.png"
					alt="Google" width="48">
				</a>
			</div>
	</div>
</body>

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	margin: 0;
}

.container {
	width: 100%;
	max-width: 800px;
	padding: 40px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	margin-bottom: 20px;
	font-size: 24px;
}

p {
	text-align: center;
	color: #666;
	margin-bottom: 30px;
}

form {
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
}

.form-group {
	width: 48%;
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

input[type="text"],
input[type="email"],
input[type="password"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
}

.error {
	color: red;
	font-size: 12px;
	margin-top: -10px;
	margin-bottom: 10px;
}

.btn {
	width: 100%;
	padding: 10px;
	background-color: #d9534f;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	margin-top: 10px;
}

.btn:hover {
	background-color: #c9302c;
}

.social-login {
	display: flex;
	gap: 10px; /* Khoảng cách giữa các icon */
	justify-content: center;
	align-items: center;
}

.social-login a img {
	transition: transform 0.3s ease; /* Hiệu ứng khi hover */
}

.social-login a img:hover {
	transform: scale(1.1); /* Phóng to khi di chuột */
}


.btn-link {
	display: inline-block;
	margin-top: 10px;
	text-align: center;
	color: #007bff;
	text-decoration: none;
}
</style>
</html>