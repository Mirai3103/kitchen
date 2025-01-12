<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<title>Login</title>

</head>
<body>
	<div class="container">
		<h1>Đăng nhập</h1>
		<p>Nếu bạn có tài khoản, hãy đăng nhập dưới đây.</p>
		<form action="<%=request.getContextPath()%>/login" method="post"
			name="frm-login">
			<div class="form-group">
				<label for="username">Email *</label> <input type="text"
					id="username" name="username" placeholder="Email" required>
				<div id="usernameError" class="error">* Bắt buộc</div>
			</div>
			<div class="form-group">
				<label for="password">Mật khẩu *</label> <input type="password"
					id="password" name="password" placeholder="Mật khẩu" required>
				<div id="passwordError" class="error"></div>
			</div>
			<div class="form-actions">
				<button type="submit" class="btn">Đăng nhập</button>
				<a href="<%=request.getContextPath()%>/register">Đăng kí ngay!</a>
			</div>
			<div class="social-login">
				<!-- Link to Facebook -->
				<a href="https://www.facebook.com" target="_blank"
					title="Đăng nhập với Facebook"> <img
					src="https://cdn-icons-png.flaticon.com/512/733/733547.png"
					alt="Facebook" width="48">
				</a>

				<!-- Link to Google -->
				<a href="https://accounts.google.com/signin" target="_blank"
					title="Đăng nhập với Google"> <img
					src="https://cdn-icons-png.flaticon.com/512/300/300221.png"
					alt="Google" width="48">
				</a>
			</div>

		</form>
	</div>
</body>

<style>
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background-color: #f5f5f5;
}

.container {
	background-color: #fff;
	padding: 40px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	width: 400px;
}

.container h1 {
	font-size: 24px;
	margin-bottom: 10px;
}

.container p {
	font-size: 14px;
	color: #666;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 15px;
	text-align: left;
}

.form-group label {
	display: block;
	font-size: 14px;
	color: #333;
	margin-bottom: 5px;
}

.form-group input {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.form-actions {
	margin-top: 20px;
	text-align: left;
}

.form-actions button {
	padding: 10px 20px;
	font-size: 14px;
	color: #fff;
	background-color: #d9534f;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.form-actions a {
	margin-left: 20px;
	font-size: 14px;
	color: #007bff;
	text-decoration: none;
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

.error {
	color: red;
	font-size: 12px;
}
</style>
</html>