<%-- 
    Document   : thongtin_user
    Created on : Mar 14, 2025, 7:46:41 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<%@page import="dao.UserDAO" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required Meta Tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Document Title, Description, and Author -->
        <title>Console - Free Bootstrap Admin Template</title>
        <meta name="description" content="Console is a Free Bootstrap Admin Template.">
        <meta name="author" content="BootstrapBrain">

        <!-- Favicon and Touch Icons -->
        <link rel="icon" type="image/png" sizes="512x512" href="./assets/favicon/favicon-512x512.png">

        <!-- Google Fonts Files -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- CSS Files -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./assets/css/console-bsb.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <section class="py-3 py-md-4 py-xl-5 bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <h1 class="h4">Basic</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb m-0 fs-7">
                                <li class="breadcrumb-item"><a class="link-primary text-decoration-none" href="index.html">Home</a></li>
                                <li class="breadcrumb-item">Tables</li>
                                <li class="breadcrumb-item active" aria-current="page">Basic</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <section class="pb-3 pb-md-4 pb-xl-5 bg-light">
            <div class="container">
                <div class="row gy-3 gy-md-4">

                    <!-- Users Table -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            User List
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th style="width: 10%;">ID</th>
                                        <th style="width: 10%;">Full Name</th>
                                        
                                        <th style="width: 10%;">Gender</th>
                                        <th style="width: 10%;">City</th>
                                        <th style="width: 15%;">Email</th>
                                        <th style="width: 10%;">Role</th>
                                        <th style="width: 10%;">Phone</th>
                                        <th style="width: 15%;">Address</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${UserDAO.getUserIncludeRole()}" var="o">
                                        <tr>
                                            <td>${o.getIDCard()}</td>
                                            <td>${o.getFirstName()}${o.getLastName()}</td>
                                            <td>${o.getGender()}</td>
                                            <td>${o.getCity()}</td>
                                            <td>${o.getEmail()}</td>
                                            <td>${o.getRoleName()}</td>
                                            <td>${o.getPhoneNumber()}</td>
                                            <td>${o.getAddress()}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Thêm DataTables -->
                    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
                    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

                    <script>
                        $(document).ready(function () {
                            $('#datatablesSimple').DataTable();
                        });
                    </script>

                </div>
            </div>
        </section>


        <jsp:include page="aside.jsp" />
        <script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <script src="https://cdn.jsdelivr.net/npm/jsvectormap"></script>
        <script src="https://cdn.jsdelivr.net/npm/jsvectormap/dist/maps/world-merc.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/bootstrap5@6.1.9/index.global.min.js"></script>

        <!-- Javascript Files: Controllers -->
        <script src="./assets/controller/console-bsb.js"></script>
        <script src="./assets/controller/chart-1.js"></script>
        <script src="./assets/controller/chart-3.js"></script>
        <script src="./assets/controller/chart-4.js"></script>
        <script src="./assets/controller/map-2.js"></script>
        <script src="./assets/controller/calendar-1.js"></script>
    </body>
</html>
