<%-- 
    Document   : trang_duyet_thong_tin
    Created on : Mar 19, 2025, 8:41:15 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<%@page import="model.Registrations" %>
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

        <section class="pb-3 pb-md-4 pb-xl-5 bg-light">
            <div class="container">
                <div class="row gy-3 gy-md-4">
                    <div class="col-12">
                        <div class="card widget-card border-light shadow-sm">
                            <div class="card-header bg-transparent p-4 border-light-subtle">
                                <h5 class="card-title widget-card-title m-0">Residence Registration Form</h5>
                            </div>
                            <div class="card-body p-4">
                                <form class="row g-3" action="Kiem_duyet" method="post">
                                    <input type="hidden" >

                                    <!-- Nhóm 1: Thông tin định danh -->
                                    <div class="col-md-6">
                                        <label for="registrationId" class="form-label">Registration ID:</label>
                                        <input type="text" class="form-control" id="registrationId" name="registrationId" value="${list.getRegistrationID()}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="idCard" class="form-label">ID Card:</label>
                                        <input type="text" class="form-control" id="idCard" name="idCard" value="${list.getIDCard()}"  readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="fullName" class="form-label">Full Name:</label>
                                        <input type="text" class="form-control" id="fullName" name="fullName" value="${list.getFirstName()} ${list.getLastName()}"  readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="relationship" class="form-label">Relationship:</label>
                                        <input type="text" class="form-control" id="relationship" name="relationship" value="${list.getRelationship()}" readonly>
                                    </div>

                                    <!-- Nhóm 2: Thông tin địa chỉ -->
                                    <div class="col-md-6">
                                        <label for="address" class="form-label">Address:</label>
                                        <input type="text" class="form-control" id="address" name="address" value="${list.getAddress()}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="city" class="form-label">City:</label>
                                        <input type="text" class="form-control" id="city" name="city" value="${list.getCity()}" readonly>
                                    </div>

                                    <!-- Nhóm 3: Thông tin đăng ký -->
                                    <div class="col-md-6">
                                        <label for="registrationType" class="form-label">Registration Type:</label>
                                        <input type="text" class="form-control" id="registrationType" name="registrationType" value="${list.getApprovedBy()}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="headOfHouseholdId" class="form-label">Head of Household ID:</label>
                                        <input type="text" class="form-control" id="headOfHouseholdId" name="headOfHouseholdId" value="${list.getHeadOfHouseholdID()}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="startDate" class="form-label">Start Date:</label>
                                        <input type="text" class="form-control" id="startDate" name="startDate" value="${list.getStartDate()}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="endDate" class="form-label">End Date:</label>
                                        <input type="text" class="form-control" id="endDate" name="endDate" value="${list.getEndDate()}" readonly>
                                    </div>

                                    <!-- Nhóm 4: Thông tin phê duyệt và ghi chú -->
                                    <div class="col-md-6">
                                        <label for="createdDate" class="form-label">Created Date:</label>
                                        <input type="text" class="form-control" id="createdDate" name="createdDate" value="${list.getCreatedDate()}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="approvedBy" class="form-label">Approved By:</label>
                                        <input type="text" class="form-control" id="approvedBy" name="approvedBy" value="${list.getApprovedBy()}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="comments" class="form-label">Comments:</label>
                                        <input type="text" class="form-control" id="comments" name="comments" value="${list.getComments()}" readonly>
                                    </div>

                                    <!-- Nút hành động -->
                                    <div class="col-12 mt-4">
                                        <div class="d-flex gap-2">
                                            <button type="submit" class="btn btn-primary" name="submitAction" value="approve">Approve</button>
                                            <button type="submit" class="btn btn-danger" name="submitAction" value="reject">Reject</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
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

        <script src="./assets/controller/console-bsb.js"></script>
        <script src="./assets/controller/chart-1.js"></script>
        <script src="./assets/controller/chart-3.js"></script>
        <script src="./assets/controller/chart-4.js"></script>
        <script src="./assets/controller/map-2.js"></script>
        <script src="./assets/controller/calendar-1.js"></script>
    </body>
</body>
</html>
