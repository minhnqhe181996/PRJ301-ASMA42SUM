<%-- 
    Document   : History_user
    Created on : Mar 19, 2025, 9:23:55 PM
    Author     : LENOVO
--%>

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
        <div class="container py-5">
            <h2 class="text-center text-primary fw-bold">Lịch sử đăng ký</h2>
            <div class="table-responsive ">
                <table class="table table-bordered table-striped align-middle m-0">
                    <thead class="table-dark" >
                        <tr>
                            <th style="width: 7%;">#</th>
                            <th style="width: 7%;">CMND/CCCD</th>
                            <th style="width: 7%;">Tên</th>
                            <th style="width: 7%;">Ngày bắt đầu</th>
                            <th style="width: 7%;">Ngày kết thúc</th>
                            <th style="width: 7%;">Quan hệ</th>
                            <th style="width: 7%;">Chủ hộ</th>
                            <th style="width: 7%;">Địa chỉ</th>
                            <th style="width: 7%;">Thành phố</th>
                            <th style="width: 7%;">Ghi chú</th>
                            <th style="width: 7%;">Loại đăng ký</th>
                            <th style="width: 7%;">Người duyệt</th>
                            <th style="width: 7%;">Ngày đăng ký</th>
                            <th style="width: 7%;">Trạng thái</th>

                        </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${list}" var="o">
                        <tr>
                            <td>${o.getRegistrationID()}</td>
                            <td>${o.getIDCard()}</td>
                            <td>${o.getFirstName()}${o.getLastName()}</td>
                            <td>${o.getStartDate()}</td>
                            <td>${o.getEndDate()}</td>
                            <td>${o.getRelationship()}</td>
                            <td>${o.getHeadOfHouseholdID()}</td>
                            <td>${o.getAddress()}</td>
                            <td>${o.getCity()}</td>
                            <td>${o.getComments()}</td>
                            <td>${o.getRegistrationType()}</td>
                            <td>${o.getApprovedBy()}</td>
                            <td>${o.getCreatedDate()}</td>
                            <td>
                        <c:choose>
                            <c:when test="${o.getStatus() == 'Pending'}">
                                <span class="badge bg-warning">Pending</span>
                            </c:when>
                            <c:when test="${o.getStatus() == 'Approved'}">
                                <span class="badge bg-success">Approved</span>
                            </c:when>
                            <c:when test="${o.getStatus() == 'Rejected'}">
                                <span class="badge bg-danger">Rejected</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">${o.getStatus()}</span>
                            </c:otherwise>
                        </c:choose>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

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
