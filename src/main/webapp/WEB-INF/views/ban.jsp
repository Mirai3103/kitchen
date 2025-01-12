<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.prj.restaurant_kitchen.entities.Phong"%>
<%@ page import="com.prj.restaurant_kitchen.entities.Ban"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Danh sách bàn</title>
</head>
<body>
	<h1>Danh sách bàn trong phòng ${idPhong}</h1>
	<form method="post" action="phong">
		<label for="tenBan">Tên bàn:</label> <input type="text" name="tenBan"
			id="tenBan" required> <label for="status">Trạng thái:</label>
		<select name="status" id="status">
			<option value="null">Available</option>
			<option value="phuc_vu">Occupied</option>
		</select> <input type="hidden" name="idPhong"
			value="<%=request.getAttribute("idPhong")%>"> <input
			type="hidden" name="action" value="addBan">
		<button type="submit">Thêm Bàn</button>
	</form>

	<table border="1">
		<thead>
			<tr>
				<th>Tên bàn</th>
				<th>Trạng thái</th>
			</tr>
		</thead>
		<tbody>
			<%
			List<Ban> banList = (List<Ban>) request.getAttribute("banList");
			if (banList != null) {
				for (Ban ban : banList) {
			%>
			<tr>
				<td><%=ban.getTenBan()%></td>
				<td><%=ban.getStatus()%></td>
			</tr>
			<%
			}
			}
			%>

		</tbody>
	</table>
	<a href="phong">Quay lại danh sách phòng</a>
</body>
</html>
