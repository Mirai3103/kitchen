<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.prj.restaurant_kitchen.entities.Material" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Material and Batch List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/dayjs@1.11.7/dayjs.min.js"></script>
    <style>
        .badge-yellow {
            background-color: #ffc107;
            color: #000;
        }
        .badge-red {
            background-color: #dc3545;
            color: #fff;
        }
        .badge-green {
            background-color: #28a745;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container mt-5" x-data="materialData()">
     
        <div class="d-flex justify-content-between">
            <h2 class="mb-4">Danh sách nguyên liệu và lô  nguyên liệu</h2>
            <a href="/home">Quay lại</a>
	    </div>
        <div class="accordion" id="materialAccordion">
            <template x-for="(material, index) in materials" :key="material.id">
                <div class="accordion-item">
                  <h2 class="accordion-header" :id="'heading' + material.id">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                :data-bs-target="'#collapse' + material.id" aria-expanded="false"
                                :aria-controls="'collapse' + material.id">
                            <div class="material-info">
                                <span class="material-id" x-text="'#' + material.id"></span>
                                <span class="material-name" x-text="material.name"></span>
                            </div>
                        </button>
                    </h2>
                    <div :id="'collapse' + material.id" class="accordion-collapse collapse"
                         :aria-labelledby="'heading' + material.id" data-bs-parent="#materialAccordion">
                        <div class="accordion-body">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>
                                        Mã lô
                                        </th>
                                        <th>
                                        Số lượng
                                        </th>
                                        <th>
                                        Hạn sử dụng
                                        </th>
                                        <th>
                                        Trạng thái
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template x-for="batch in material.materialBatches" :key="batch.id">
                                        <tr>
                                            <td x-text="batch.id"></td>
                                            <td x-text="batch.quantity + ' ' + material.unit"></td>
                                            <td x-text="formatDate(batch.expiredDate)"></td>
                                            <td>
                                                <span class="badge" :class="getBadgeClass(batch.expiredDate)"
                                                      x-text="getStatus(batch.expiredDate)"></span>
                                            </td>
                                        </tr>
                                    </template>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </template>
        </div>
    </div>
    <%
    String list = (String)request.getAttribute("materialsJson");
  // Sử dụng thư viện Gson để chuyển đổi
%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const myList = <%= list %>;
        function materialData() {
            return {
                materials: myList,
                formatDate(date) {
                    return dayjs(date).format('DD/MM/YYYY');
                },
                getBadgeClass(date) {
                    const daysUntilExpiry = dayjs(date).diff(dayjs(), 'day');
                    if (daysUntilExpiry < 0) return 'badge-red';
                    if (daysUntilExpiry <= 3) return 'badge-yellow';
                    return 'badge-green';
                },
                getStatus(date) {
                    const daysUntilExpiry = dayjs(date).diff(dayjs(), 'day');
                    if (daysUntilExpiry < 0) return 'Expired';
                    if (daysUntilExpiry <= 3) return 'Expiring Soon';
                    return 'Valid';
                }
            }
        }
    </script>
</body>
</html>