<%-- 
    Document   : add_user
    Created on : Mar 14, 2025, 3:15:00 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<%@page import="model.Roles" %>
<%@page import="dao.RoleDAO" %>
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
        <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
        <section class="pb-3 pb-md-4 pb-xl-5 bg-light">
            <div class="container">
                <div class="row gy-3 gy-md-4">
                    <div class="col-12">
                        <div class="card widget-card border-light shadow-sm">
                            <div class="card-header bg-transparent p-4 border-light-subtle">
                                <h5 class="card-title widget-card-title m-0">Residence Registration Form</h5>
                            </div>
                            <div class="card-body p-4">
                                <form class="row g-3" action="adduser" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <div class="col-md-6">
                                        <label for="inputIDCard" class="form-label">ID Card</label>
                                        <input type="text" class="form-control" id="inputIDCard" name="id"required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="inputRole" class="form-label">Role</label>
                                        <select id="inputRole" class="form-select" name="role">

                                            <option selected value="1">Citizen</option>->

                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="inputFirstName" class="form-label">First Name</label>
                                        <input type="text" class="form-control" id="inputFirstName" name="fname" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="inputLastName" class="form-label">Last Name</label>
                                        <input type="text" class="form-control" id="inputLastName" name="lname" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="inputGender" class="form-label">Gender</label>
                                        <select id="inputGender" class="form-select" name="gender">
                                            <option selected>Choose...</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="inputCity" class="form-label">City</label>
                                        <select id="inputCity" class="form-select" style="width: 100%;" name="city">
                                            <option value="">Choose...</option>
                                            <option value="An Giang">An Giang</option>
                                            <option value="Ba Ria - Vung Tau">Ba Ria - Vung Tau</option>
                                            <option value="Bac Giang">Bac Giang</option>
                                            <option value="Bac Kan">Bac Kan</option>
                                            <option value="Bac Lieu">Bac Lieu</option>
                                            <option value="Bac Ninh">Bac Ninh</option>
                                            <option value="Ben Tre">Ben Tre</option>
                                            <option value="Binh Dinh">Binh Dinh</option>
                                            <option value="Binh Duong">Binh Duong</option>
                                            <option value="Binh Phuoc">Binh Phuoc</option>
                                            <option value="Binh Thuan">Binh Thuan</option>
                                            <option value="Ca Mau">Ca Mau</option>
                                            <option value="Can Tho">Can Tho</option>
                                            <option value="Cao Bang">Cao Bang</option>
                                            <option value="Da Nang">Da Nang</option>
                                            <option value="Dak Lak">Dak Lak</option>
                                            <option value="Dak Nong">Dak Nong</option>
                                            <option value="Dien Bien">Dien Bien</option>
                                            <option value="Dong Nai">Dong Nai</option>
                                            <option value="Dong Thap">Dong Thap</option>
                                            <option value="Gia Lai">Gia Lai</option>
                                            <option value="Ha Giang">Ha Giang</option>
                                            <option value="Ha Nam">Ha Nam</option>
                                            <option value="Ha Noi">Ha Noi</option>
                                            <option value="Ha Tinh">Ha Tinh</option>
                                            <option value="Hai Duong">Hai Duong</option>
                                            <option value="Hai Phong">Hai Phong</option>
                                            <option value="Hau Giang">Hau Giang</option>
                                            <option value="Hoa Binh">Hoa Binh</option>
                                            <option value="Hung Yen">Hung Yen</option>
                                            <option value="Khanh Hoa">Khanh Hoa</option>
                                            <option value="Kien Giang">Kien Giang</option>
                                            <option value="Kon Tum">Kon Tum</option>
                                            <option value="Lai Chau">Lai Chau</option>
                                            <option value="Lam Dong">Lam Dong</option>
                                            <option value="Lang Son">Lang Son</option>
                                            <option value="Lao Cai">Lao Cai</option>
                                            <option value="Long An">Long An</option>
                                            <option value="Nam Dinh">Nam Dinh</option>
                                            <option value="Nghe An">Nghe An</option>
                                            <option value="Ninh Binh">Ninh Binh</option>
                                            <option value="Ninh Thuan">Ninh Thuan</option>
                                            <option value="Phu Tho">Phu Tho</option>
                                            <option value="Phu Yen">Phu Yen</option>
                                            <option value="Quang Binh">Quang Binh</option>
                                            <option value="Quang Nam">Quang Nam</option>
                                            <option value="Quang Ngai">Quang Ngai</option>
                                            <option value="Quang Ninh">Quang Ninh</option>
                                            <option value="Quang Tri">Quang Tri</option>
                                            <option value="Soc Trang">Soc Trang</option>
                                            <option value="Son La">Son La</option>
                                            <option value="Tay Ninh">Tay Ninh</option>
                                            <option value="Thai Binh">Thai Binh</option>
                                            <option value="Thai Nguyen">Thai Nguyen</option>
                                            <option value="Thanh Hoa">Thanh Hoa</option>
                                            <option value="Thua Thien Hue">Thua Thien Hue</option>
                                            <option value="Tien Giang">Tien Giang</option>
                                            <option value="TP Ho Chi Minh">TP Ho Chi Minh</option>
                                            <option value="Tra Vinh">Tra Vinh</option>
                                            <option value="Tuyen Quang">Tuyen Quang</option>
                                            <option value="Vinh Long">Vinh Long</option>
                                            <option value="Vinh Phuc">Vinh Phuc</option>
                                            <option value="Yen Bai">Yen Bai</option>

                                        </select>
                                    </div>

                                    <!-- Thêm thư viện Select2 để có ô tìm kiếm -->
                                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0/dist/js/select2.min.js"></script>
                                    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0/dist/css/select2.min.css">

                                    <script>
                                        $(document).ready(function () {
                                            $('#inputCity').select2({
                                                placeholder: "Chọn thành phố",
                                                allowClear: true
                                            });
                                        });
                                    </script>
                                    <div class="col-12">
                                        <label for="inputAddress" class="form-label">Address</label>
                                        <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" name="address" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="inputPhone" class="form-label">Phone Number</label>
                                        <input type="text" class="form-control" id="inputPhone" name="phone" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="inputEmail" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="inputEmail" name="email" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="inputPassword" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="inputPassword" name="pass" required>
                                    </div>

                                    <div class="col-12">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="gridCheck">
                                            <label class="form-check-label" for="gridCheck">
                                                Agree to terms and conditions
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">Register</button>
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
</html>
