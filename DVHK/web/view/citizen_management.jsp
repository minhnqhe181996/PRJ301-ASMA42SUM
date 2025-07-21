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
    <link rel="icon" type="image/png" sizes="512x512" href="<%=request.getContextPath()%>/assets/favicon/favicon-512x512.png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/console-bsb.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <style>
        .table { width: 100%; }
        .dataTables_wrapper .dataTables_filter { float: right; margin-bottom: 10px; }
        .dataTables_wrapper .dataTables_paginate { float: right; margin-top: 10px; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <section class="py-3 py-md-4 py-xl-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h1 class="h4">
                        <c:choose>
                            <c:when test="${user.getRoleID() == 2}">
                                Thông tin cư dân thành phố ${user.getCity()}
                            </c:when>
                            <c:otherwise>
                                Quản lý thông tin người dùng
                            </c:otherwise>
                        </c:choose>
                    </h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb m-0 fs-7">
                            <li class="breadcrumb-item"><a class="link-primary text-decoration-none" href="Management">Home</a></li>
                            <li class="breadcrumb-item">Tables</li>
                            <li class="breadcrumb-item active" aria-current="page">Thông tin cư dân</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <section class="pb-3 pb-md-4 pb-xl-5 bg-light">
        <div class="container">
            <div class="row gy-3 gy-md-4">
                <!-- Bảng thông tin công dân -->
                <div class="col-12">
                    <div class="card widget-card border-light shadow-sm">
                        <div class="card-body p-4">
                            <h5 class="mb-3">
                                <c:choose>
                                    <c:when test="${user.getRoleID() == 2}">
                                        Thông tin cư dân thành phố ${user.getCity()}
                                    </c:when>
                                    <c:otherwise>
                                        Thông tin cư dân
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <hr>
                            <table class="table table-striped table-hover align-middle" id="citizenTable">
                                <thead>
                                    <tr>
                                        <th style="width: 5%;">#</th>
                                        <th style="width: 15%;">ID Card</th>
                                        <th style="width: 10%;">First Name</th>
                                        <th style="width: 10%;">Last Name</th>
                                        <th style="width: 10%;">Gender</th>
                                        <th style="width: 10%;">City</th>
                                        <th style="width: 15%;">Phone Number</th>
                                        <th style="width: 15%;">Email</th>
                                        <th style="width: 20%;">Address</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty citizenList}">
                                            <tr>
                                                <td colspan="9" class="text-center">No data found!</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${citizenList}" var="o" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${o.IDCard != null ? o.IDCard : '-'}</td>
                                                    <td>${o.firstName != null ? o.firstName : '-'}</td>
                                                    <td>${o.lastName != null ? o.lastName : '-'}</td>
                                                    <td>${o.gender != null ? o.gender : '-'}</td>
                                                    <td>${o.city != null ? o.city : '-'}</td>
                                                    <td>${o.phoneNumber != null ? o.phoneNumber : '-'}</td>
                                                    <td>${o.email != null ? o.email : '-'}</td>
                                                    <td>${o.address != null ? o.address : '-'}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Bảng thông tin cảnh sát (chỉ hiển thị cho Admin) -->
                <c:if test="${user.getRoleID() == 3}">
                    <div class="col-12">
                        <div class="card widget-card border-light shadow-sm">
                            <div class="card-body p-4">
                                <h5 class="mb-3">Thông tin cảnh sát</h5>
                                <hr>
                                <table class="table table-striped table-hover align-middle" id="policeTable">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%;">#</th>
                                            <th style="width: 15%;">ID Card</th>
                                            <th style="width: 10%;">First Name</th>
                                            <th style="width: 10%;">Last Name</th>
                                            <th style="width: 10%;">Gender</th>
                                            <th style="width: 10%;">City</th>
                                            <th style="width: 15%;">Phone Number</th>
                                            <th style="width: 15%;">Email</th>
                                            <th style="width: 20%;">Address</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty policeList}">
                                                <tr>
                                                    <td colspan="9" class="text-center">No data found!</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${policeList}" var="o" varStatus="status">
                                                    <tr>
                                                        <td>${status.index + 1}</td>
                                                        <td>${o.IDCard != null ? o.IDCard : '-'}</td>
                                                        <td>${o.firstName != null ? o.firstName : '-'}</td>
                                                        <td>${o.lastName != null ? o.lastName : '-'}</td>
                                                        <td>${o.gender != null ? o.gender : '-'}</td>
                                                        <td>${o.city != null ? o.city : '-'}</td>
                                                        <td>${o.phoneNumber != null ? o.phoneNumber : '-'}</td>
                                                        <td>${o.email != null ? o.email : '-'}</td>
                                                        <td>${o.address != null ? o.address : '-'}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Bảng thông tin Admin (chỉ hiển thị cho Admin) -->
                <c:if test="${user.getRoleID() == 3}">
                    <div class="col-12">
                        <div class="card widget-card border-light shadow-sm">
                            <div class="card-body p-4">
                                <h5 class="mb-3">Thông tin quản trị viên</h5>
                                <hr>
                                <table class="table table-striped table-hover align-middle" id="adminTable">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%;">#</th>
                                            <th style="width: 15%;">ID Card</th>
                                            <th style="width: 10%;">First Name</th>
                                            <th style="width: 10%;">Last Name</th>
                                            <th style="width: 10%;">Gender</th>
                                            <th style="width: 10%;">City</th>
                                            <th style="width: 15%;">Phone Number</th>
                                            <th style="width: 15%;">Email</th>
                                            <th style="width: 20%;">Address</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty adminList}">
                                                <tr>
                                                    <td colspan="9" class="text-center">No data found!</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${adminList}" var="o" varStatus="status">
                                                    <tr>
                                                        <td>${status.index + 1}</td>
                                                        <td>${o.IDCard != null ? o.IDCard : '-'}</td>
                                                        <td>${o.firstName != null ? o.firstName : '-'}</td>
                                                        <td>${o.lastName != null ? o.lastName : '-'}</td>
                                                        <td>${o.gender != null ? o.gender : '-'}</td>
                                                        <td>${o.city != null ? o.city : '-'}</td>
                                                        <td>${o.phoneNumber != null ? o.phoneNumber : '-'}</td>
                                                        <td>${o.email != null ? o.email : '-'}</td>
                                                        <td>${o.address != null ? o.address : '-'}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <jsp:include page="aside.jsp" />

    <!-- Thêm DataTables JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#citizenTable').DataTable({
                "paging": true,
                "searching": true,
                "pageLength": 10,
                "lengthChange": true,
                "info": true,
                "autoWidth": false // Tắt tự động tính toán chiều rộng cột
            });
            $('#policeTable').DataTable({
                "paging": true,
                "searching": true,
                "pageLength": 10,
                "lengthChange": true,
                "info": true,
                "autoWidth": false
            });
            $('#adminTable').DataTable({
                "paging": true,
                "searching": true,
                "pageLength": 10,
                "lengthChange": true,
                "info": true,
                "autoWidth": false
            });
        });
    </script>

    <script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/controller/console-bsb.js"></script>
</body>
</html>