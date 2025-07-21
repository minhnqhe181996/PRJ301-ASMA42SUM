<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Thông Báo - Quản lý hệ thống cư trú</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <link href="img/hero-img-1.png" rel="icon">
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@500;600;700&family=Rubik:wght@400;500&display=swap" rel="stylesheet">
        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <!-- Bootstrap and Custom Styles -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header_user.jsp" />

        <!-- Header Start -->
        <div class="container-fluid bg-breadcrumb">
            <ul class="breadcrumb-animation">
                <li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li>
            </ul>
            <div class="container text-center py-5" style="max-width: 900px;">
                <h3 class="display-3 mb-4 wow fadeInDown" data-wow-delay="0.1s">Thông Báo</h3>
                <ol class="breadcrumb justify-content-center mb-0 wow fadeInDown" data-wow-delay="0.3s">
                    <li class="breadcrumb-item"><a href="User">Trang chủ</a></li>
                    <li class="breadcrumb-item active text-primary">Thông Báo</li>
                </ol>
            </div>
        </div>
        <!-- Header End -->

        <!-- Notification Content Start -->
        <div class="container py-5">
            <h2 class="text-center mb-4 fw-bold text-primary wow fadeInUp" data-wow-delay="0.1s">
                <i class="fas fa-bell"></i> Thông Báo Dịch Vụ Công
            </h2>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger wow fadeInUp" data-wow-delay="0.2s">${error}</div>
            </c:if>

            <!-- Notification Table -->
            <div class="table-responsive wow fadeInUp" data-wow-delay="0.3s">
                <table class="table table-bordered table-hover">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Thông báo</th>
                            <th scope="col">Ngày gửi</th>
                            <th scope="col">Trạng thái</th>
                            <th scope="col">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${notifications}" var="notification" varStatus="loop">
                            <tr>
                                <td>${loop.count}</td>
                                <td>${notification.message}</td>
                                <td>${notification.sentDate}</td>
                                <td>
                                    <span class="badge ${notification.isRead ? 'bg-success' : 'bg-warning'}">
                                        ${notification.isRead ? 'Đã đọc' : 'Chưa đọc'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-primary btn-sm view-btn" 
                                            data-id="${notification.notificationID}"
                                            data-message="${notification.message}"
                                            data-bs-toggle="modal" 
                                            data-bs-target="#notificationDetailModal">
                                        <i class="fas fa-eye"></i> Xem
                                    </button>
                                    <c:if test="${!notification.isRead}">
                                        <form action="Notification" method="post" style="display: inline;">
                                            <input type="hidden" name="notificationId" value="${notification.notificationID}">
                                            <button type="submit" class="btn btn-success btn-sm">
                                                <i class="fas fa-check"></i> Đánh dấu đã đọc
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            


            <!-- Modal for Notification Details -->
            <div class="modal fade" id="notificationDetailModal" tabindex="-1" aria-labelledby="notificationDetailModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="notificationDetailModalLabel">Chi tiết thông báo</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" id="notificationDetailContent">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer_user.jsp" />
        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/lightbox/js/lightbox.min.js"></script>
        <script src="js/main.js"></script>

        <!-- Custom JavaScript -->
        <script>
            $(document).ready(function () {
                // View button click handler
                $('.view-btn').click(function () {
                    var message = $(this).data('message');
                    $('#notificationDetailContent').text(message);
                });
            });
        </script>
    </body>
</html>