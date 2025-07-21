<%-- 
    Document   : trang_police
    Created on : Mar 12, 2025, 1:17:40 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Console - Free Bootstrap Admin Template</title>
        <meta name="description" content="Console is a Free Bootstrap Admin Template.">
        <meta name="author" content="BootstrapBrain">
        <link rel="icon" type="image/png" sizes="512x512" href="./assets/favicon/favicon-512x512.png">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="./assets/css/console-bsb.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jsvectormap/dist/css/jsvectormap.min.css">
        <style>
        .row {
            margin-left: 0;
            margin-right: 0;
        }
        .card {
            height: 100%; /* Đảm bảo các box có chiều cao đồng đều */
        }
    </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
    <main id="main">
        <section class="py-3 py-md-4 py-xl-5 bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <h1 class="h4">Dashboard</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="pb-3 pb-md-4 pb-xl-5 bg-light">
            <div class="container">
                <div class="row gy-3 gy-md-4">
                    <!-- Người chờ duyệt -->
                    <div class="${user.getRoleID() == 2 ? 'col-12 col-md-4' : 'col-12 col-md-3'}">
                        <div class="card widget-card border-light shadow-sm">
                            <div class="card-body p-4"> 
                                <div class="row">
                                    <div class="col-8">
                                        <c:if test="${user.getRoleID() == 2}">
                                            <h5 class="card-title widget-card-title mb-3">Số người chờ duyệt thành phố ${user.getCity()}</h5>
                                        </c:if>
                                        <c:if test="${user.getRoleID() == 3}">
                                            <h5 class="card-title widget-card-title mb-3">Tổng số người chờ duyệt</h5>
                                        </c:if>
                                        <h4 class="card-subtitle text-body-secondary m-0">${pendingUsersCount}</h4>
                                    </div>
                                    <div class="col-4">
                                        <div class="lh-1 text-white bg-primary rounded-circle p-3 d-flex align-items-center justify-content-center">
                                            <i class="bi bi-person-check fs-4"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Người đã duyệt -->
                    <div class="${user.getRoleID() == 2 ? 'col-12 col-md-4' : 'col-12 col-md-3'}">
                        <div class="card widget-card border-light shadow-sm">
                            <div class="card-body p-4">
                                <div class="row">
                                    <div class="col-8">
                                        <c:if test="${user.getRoleID() == 2}">
                                            <h5 class="card-title widget-card-title mb-3">Số người đã duyệt thành phố ${user.getCity()}</h5>
                                        </c:if>
                                        <c:if test="${user.getRoleID() == 3}">
                                            <h5 class="card-title widget-card-title mb-3">Tổng số người đã duyệt</h5>
                                        </c:if>
                                        <h4 class="card-subtitle text-body-secondary m-0">${processedUsersCount}</h4>
                                    </div>
                                    <div class="col-4">
                                        <div class="lh-1 text-white bg-primary rounded-circle p-3 d-flex align-items-center justify-content-center">
                                            <i class="bi bi-check-circle fs-4"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Tổng số dân cư -->
                    <div class="${user.getRoleID() == 2 ? 'col-12 col-md-4' : 'col-12 col-md-3'}">
                        <div class="card widget-card border-light shadow-sm">
                            <div class="card-body p-4">
                                <div class="row">
                                    <div class="col-8">
                                        <c:if test="${user.getRoleID() == 2}">
                                            <h5 class="card-title widget-card-title mb-3">Số dân cư thành phố ${user.getCity()}</h5>
                                        </c:if>
                                        <c:if test="${user.getRoleID() == 3}">
                                            <h5 class="card-title widget-card-title mb-3">Tổng số dân cư</h5>
                                        </c:if>
                                        <h4 class="card-subtitle text-body-secondary m-0">${totalUsersCount}</h4>
                                    </div>
                                    <div class="col-4">
                                        <div class="lh-1 text-white bg-primary rounded-circle p-3 d-flex align-items-center justify-content-center">
                                            <i class="bi bi-people fs-4"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Tổng số cảnh sát (chỉ hiển thị cho admin) -->
                    <c:if test="${user.getRoleID() == 3}">
                        <div class="col-12 col-md-3">
                            <div class="card widget-card border-light shadow-sm">
                                <div class="card-body p-4">
                                    <div class="row">
                                        <div class="col-8">
                                            <h5 class="card-title widget-card-title mb-3">Tổng số cảnh sát</h5>
                                            <h4 class="card-subtitle text-body-secondary m-0">${policeCount}</h4>
                                        </div>
                                        <div class="col-4">
                                            <div class="lh-1 text-white bg-primary rounded-circle p-3 d-flex align-items-center justify-content-center">
                                                <i class="bi bi-shield-shaded fs-4"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>
    </main>
    <jsp:include page="aside.jsp" />
        <script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/jsvectormap"></script>
        <script src="https://cdn.jsdelivr.net/npm/jsvectormap/dist/maps/world-merc.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/bootstrap5@6.1.9/index.global.min.js"></script>
        <script src="./assets/controller/console-bsb.js"></script>
        <script src="./assets/controller/chart-1.js"></script>
        <script src="./assets/controller/chart-3.js"></script>
        <script src="./assets/controller/chart-4.js"></script>
        <script src="./assets/controller/map-2.js"></script>
        <script src="./assets/controller/calendar-1.js"></script>
    </body>
</html>