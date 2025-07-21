<%-- 
    Document   : profile
    Created on : Mar 5, 2025, 4:25:01 PM
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
        <style>
            .user-email {
                word-break: break-word;      /* Tự động xuống dòng nếu quá dài */
                overflow-wrap: break-word;   /* Đảm bảo nội dung không bị tràn */
                max-width: 100%;             /* Không vượt ra khỏi box */
                white-space: normal;         /* Đảm bảo chữ không bị thu nhỏ */
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <jsp:include page="header.jsp" />

        <!-- Main -->
        <main id="main">

            <!-- Section - Bootstrap Brain Component -->
            <!-- Breadcrumb -->
            <section class="py-3 py-md-4 py-xl-5 bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <h1 class="h4">Profile</h1>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 fs-7">
                                    <c:if test="${user.getRoleID()==1}">
                                        <li class="breadcrumb-item"><a class="link-primary text-decoration-none" href="User">Home</a></li>
                                        </c:if>
                                        <c:if test="${user.getRoleID()==2||user.getRoleID()==3}">
                                        <li class="breadcrumb-item"><a class="link-primary text-decoration-none" href="Management">Home</a></li>
                                        </c:if>
                                    <li class="breadcrumb-item active" aria-current="page">Profile</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </section>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <!-- Section - Bootstrap Brain Component -->
            <section class="pb-3 pb-md-4 pb-xl-5 bg-light">
                <div class="container">
                    <div class="row gy-4 gy-lg-0">
                        <div class="col-12 col-md-6 col-lg-4 col-xl-3">
                            <div class="row gy-4">
                                <div class="col-12">
                                    <div class="card widget-card border-light shadow-sm">
                                        <div class="card-header text-bg-primary text-center">
                                            Welcome, <c:out value="${user.getFirstName()}"/> <c:out value="${user.getLastName()}"/>
                                        </div>
                                        <div class="card-body">
                                            <div class="text-center mb-3">
                                                <img src="./assets/img/profile/profile-img-1.jpg" 
                                                     class="img-fluid rounded-circle" 
                                                     alt="<c:out value="${user.getFirstName()}"/> <c:out value="${user.getLastName()}"/>">
                                            </div>
                                            <h5 class="text-center mb-1">
                                                <c:out value="${user.getFirstName()}"/> <c:out value="${user.getLastName()}"/>
                                            </h5>
                                            <p class="text-center text-secondary mb-4 user-email">
                                                <c:out value="${user.getIDCard()}"></c:out>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-lg-8 col-xl-9">
                                <div class="card widget-card border-light shadow-sm">
                                    <div class="card-body p-4">
                                        <ul class="nav nav-tabs" id="profileTab" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link active" id="overview-tab" data-bs-toggle="tab" data-bs-target="#overview-tab-pane" type="button" role="tab" aria-controls="overview-tab-pane" aria-selected="true">Overview</button>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">Profile</button>
                                            </li>

                                            <li class="nav-item" role="presentation">
                                                <button class="nav-link" id="password-tab" data-bs-toggle="tab" data-bs-target="#password-tab-pane" type="button" role="tab" aria-controls="password-tab-pane" aria-selected="false">Password</button>
                                            </li>
                                        </ul>
                                        <div class="tab-content pt-4" id="profileTabContent">
                                            <div class="tab-pane fade show active" id="overview-tab-pane" role="tabpanel" aria-labelledby="overview-tab" tabindex="0">

                                                <h5 class="mb-3">Profile</h5>
                                                <div class="row g-0">
                                                    <div class="col-5 col-md-3 bg-light border-bottom border-white border-3">
                                                        <div class="p-2">First Name</div>
                                                    </div>
                                                    <div class="col-7 col-md-9 bg-light border-start border-bottom border-white border-3">
                                                        <div class="p-2"><c:out value="${user.getFirstName()}"></c:out></div>
                                                    </div>
                                                    <div class="col-5 col-md-3 bg-light border-bottom border-white border-3">
                                                        <div class="p-2">Last Name</div>
                                                    </div>
                                                    <div class="col-7 col-md-9 bg-light border-start border-bottom border-white border-3">
                                                        <div class="p-2"><c:out value="${user.getLastName()}"></c:out></div>
                                                    </div>
                                                    <div class="col-5 col-md-3 bg-light border-bottom border-white border-3">
                                                        <div class="p-2">Gender</div>
                                                    </div>
                                                    <div class="col-7 col-md-9 bg-light border-start border-bottom border-white border-3">
                                                        <div class="p-2"><c:out value="${user.getGender()}"></c:out></div>
                                                    </div>
                                                    <div class="col-5 col-md-3 bg-light border-bottom border-white border-3">
                                                        <div class="p-2">Address</div>
                                                    </div>
                                                    <div class="col-7 col-md-9 bg-light border-start border-bottom border-white border-3">
                                                        <div class="p-2"><c:out value="${user.getAddress()}"></c:out></div>
                                                    </div>
                                                    <div class="col-5 col-md-3 bg-light border-bottom border-white border-3">
                                                        <div class="p-2">City</div>
                                                    </div>
                                                    <div class="col-7 col-md-9 bg-light border-start border-bottom border-white border-3">
                                                        <div class="p-2"><c:out value="${user.getCity()}"></c:out></div>
                                                    </div>


                                                    <div class="col-5 col-md-3 bg-light border-bottom border-white border-3">
                                                        <div class="p-2">Phone</div>
                                                    </div>
                                                    <div class="col-7 col-md-9 bg-light border-start border-bottom border-white border-3">
                                                        <div class="p-2"><c:out value="${user.getPhoneNumber()}"></c:out></div>
                                                    </div>
                                                    <div class="col-5 col-md-3 bg-light border-bottom border-white border-3">
                                                        <div class="p-2">Email</div>
                                                    </div>
                                                    <div class="col-7 col-md-9 bg-light border-start border-bottom border-white border-3">
                                                        <div class="p-2"><c:out value="${user.getEmail()}"></c:out></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
                                                <form action="UpdateProfile" method="POST" class="row gy-3 gy-xxl-4">
                                                    <div class="col-12">
                                                        <div class="row gy-2">
                                                            <label class="col-12 form-label m-0">Profile Image</label>
                                                            <div class="col-12">
                                                                <img src="./assets/img/profile/profile-img-1.jpg" class="img-fluid" alt="Profile">
                                                            </div>
                                                            <div class="col-12">
                                                                <a href="#!" class="d-inline-block bg-primary link-light lh-1 p-2 rounded">
                                                                    <i class="bi bi-upload"></i>
                                                                </a>
                                                                <a href="#!" class="d-inline-block bg-danger link-light lh-1 p-2 rounded">
                                                                    <i class="bi bi-trash"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-md-6">
                                                        <label for="inputFirstName" class="form-label">First Name<span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" id="inputFirstName" name="inputFirstName" value="<c:out value='${user.getFirstName()}'/>">
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <label for="inputLastName" class="form-label">Last Name<span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="inputLastName" name="inputLastName" value="<c:out value='${user.getLastName()}'/>">
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <label for="inputGender" class="form-label">Gender<span class="text-danger">*</span></label>
                                                    <select class="form-control" id="inputGender" name="inputGender">
                                                        <option value="Male" ${user.getGender() == 'Male' ? 'selected' : ''}>Male</option>
                                                        <option value="Female" ${user.getGender() == 'Female' ? 'selected' : ''}>Female</option>
                                                    </select>
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <label for="inputPhone" class="form-label">Phone<span class="text-danger">*</span></label>
                                                    <input type="tel" class="form-control" id="inputPhone" name="inputPhone" value="<c:out value='${user.getPhoneNumber()}'/>">
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <label for="inputEmail" class="form-label">Email<span class="text-danger">*</span></label>
                                                    <input type="email" class="form-control" id="inputEmail" name="inputEmail" value="<c:out value='${user.getEmail()}'/>">
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <label for="inputAddress" class="form-label">Address<span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="inputAddress" name="inputAddress" value="<c:out value='${user.getAddress()}'/>">
                                                </div>
                                                <div class="col-12 col-md-6">
                                                    <label for="inputCity" class="form-label">City <span class="text-danger">*</span></label>
                                                    <select class="form-control" id="inputCity" name="inputCity">
                                                        <option value="">Choose...</option>
                                                        <option value="An Giang" ${user.getCity() == 'An Giang' ? 'selected' : ''}>An Giang</option>
                                                        <option value="Ba Ria - Vung Tau" ${user.getCity() == 'Ba Ria - Vung Tau' ? 'selected' : ''}>Ba Ria - Vung Tau</option>
                                                        <option value="Bac Giang" ${user.getCity() == 'Bac Giang' ? 'selected' : ''}>Bac Giang</option>
                                                        <option value="Bac Kan" ${user.getCity() == 'Bac Kan' ? 'selected' : ''}>Bac Kan</option>
                                                        <option value="Bac Lieu" ${user.getCity() == 'Bac Lieu' ? 'selected' : ''}>Bac Lieu</option>
                                                        <option value="Bac Ninh" ${user.getCity() == 'Bac Ninh' ? 'selected' : ''}>Bac Ninh</option>
                                                        <option value="Ben Tre" ${user.getCity() == 'Ben Tre' ? 'selected' : ''}>Ben Tre</option>
                                                        <option value="Binh Dinh" ${user.getCity() == 'Binh Dinh' ? 'selected' : ''}>Binh Dinh</option>
                                                        <option value="Binh Duong" ${user.getCity() == 'Binh Duong' ? 'selected' : ''}>Binh Duong</option>
                                                        <option value="Binh Phuoc" ${user.getCity() == 'Binh Phuoc' ? 'selected' : ''}>Binh Phuoc</option>
                                                        <option value="Binh Thuan" ${user.getCity() == 'Binh Thuan' ? 'selected' : ''}>Binh Thuan</option>
                                                        <option value="Ca Mau" ${user.getCity() == 'Ca Mau' ? 'selected' : ''}>Ca Mau</option>
                                                        <option value="Can Tho" ${user.getCity() == 'Can Tho' ? 'selected' : ''}>Can Tho</option>
                                                        <option value="Cao Bang" ${user.getCity() == 'Cao Bang' ? 'selected' : ''}>Cao Bang</option>
                                                        <option value="Da Nang" ${user.getCity() == 'Da Nang' ? 'selected' : ''}>Da Nang</option>
                                                        <option value="Dak Lak" ${user.getCity() == 'Dak Lak' ? 'selected' : ''}>Dak Lak</option>
                                                        <option value="Dak Nong" ${user.getCity() == 'Dak Nong' ? 'selected' : ''}>Dak Nong</option>
                                                        <option value="Dien Bien" ${user.getCity() == 'Dien Bien' ? 'selected' : ''}>Dien Bien</option>
                                                        <option value="Dong Nai" ${user.getCity() == 'Dong Nai' ? 'selected' : ''}>Dong Nai</option>
                                                        <option value="Dong Thap" ${user.getCity() == 'Dong Thap' ? 'selected' : ''}>Dong Thap</option>
                                                        <option value="Gia Lai" ${user.getCity() == 'Gia Lai' ? 'selected' : ''}>Gia Lai</option>
                                                        <option value="Ha Giang" ${user.getCity() == 'Ha Giang' ? 'selected' : ''}>Ha Giang</option>
                                                        <option value="Ha Nam" ${user.getCity() == 'Ha Nam' ? 'selected' : ''}>Ha Nam</option>
                                                        <option value="Ha Noi" ${user.getCity() == 'Ha Noi' ? 'selected' : ''}>Ha Noi</option>
                                                        <option value="Ha Tinh" ${user.getCity() == 'Ha Tinh' ? 'selected' : ''}>Ha Tinh</option>
                                                        <option value="Hai Duong" ${user.getCity() == 'Hai Duong' ? 'selected' : ''}>Hai Duong</option>
                                                        <option value="Hai Phong" ${user.getCity() == 'Hai Phong' ? 'selected' : ''}>Hai Phong</option>
                                                        <option value="Hau Giang" ${user.getCity() == 'Hau Giang' ? 'selected' : ''}>Hau Giang</option>
                                                        <option value="Hoa Binh" ${user.getCity() == 'Hoa Binh' ? 'selected' : ''}>Hoa Binh</option>
                                                        <option value="Hung Yen" ${user.getCity() == 'Hung Yen' ? 'selected' : ''}>Hung Yen</option>
                                                        <option value="Khanh Hoa" ${user.getCity() == 'Khanh Hoa' ? 'selected' : ''}>Khanh Hoa</option>
                                                        <option value="Kien Giang" ${user.getCity() == 'Kien Giang' ? 'selected' : ''}>Kien Giang</option>
                                                        <option value="Kon Tum" ${user.getCity() == 'Kon Tum' ? 'selected' : ''}>Kon Tum</option>
                                                        <option value="Lai Chau" ${user.getCity() == 'Lai Chau' ? 'selected' : ''}>Lai Chau</option>
                                                        <option value="Lam Dong" ${user.getCity() == 'Lam Dong' ? 'selected' : ''}>Lam Dong</option>
                                                        <option value="Lang Son" ${user.getCity() == 'Lang Son' ? 'selected' : ''}>Lang Son</option>
                                                        <option value="Lao Cai" ${user.getCity() == 'Lao Cai' ? 'selected' : ''}>Lao Cai</option>
                                                        <option value="Long An" ${user.getCity() == 'Long An' ? 'selected' : ''}>Long An</option>
                                                        <option value="Nam Dinh" ${user.getCity() == 'Nam Dinh' ? 'selected' : ''}>Nam Dinh</option>
                                                        <option value="Nghe An" ${user.getCity() == 'Nghe An' ? 'selected' : ''}>Nghe An</option>
                                                        <option value="Ninh Binh" ${user.getCity() == 'Ninh Binh' ? 'selected' : ''}>Ninh Binh</option>
                                                        <option value="Ninh Thuan" ${user.getCity() == 'Ninh Thuan' ? 'selected' : ''}>Ninh Thuan</option>
                                                        <option value="Phu Tho" ${user.getCity() == 'Phu Tho' ? 'selected' : ''}>Phu Tho</option>
                                                        <option value="Phu Yen" ${user.getCity() == 'Phu Yen' ? 'selected' : ''}>Phu Yen</option>
                                                        <option value="Quang Binh" ${user.getCity() == 'Quang Binh' ? 'selected' : ''}>Quang Binh</option>
                                                        <option value="Quang Nam" ${user.getCity() == 'Quang Nam' ? 'selected' : ''}>Quang Nam</option>
                                                        <option value="Quang Ngai" ${user.getCity() == 'Quang Ngai' ? 'selected' : ''}>Quang Ngai</option>
                                                        <option value="Quang Ninh" ${user.getCity() == 'Quang Ninh' ? 'selected' : ''}>Quang Ninh</option>
                                                        <option value="Quang Tri" ${user.getCity() == 'Quang Tri' ? 'selected' : ''}>Quang Tri</option>
                                                        <option value="Soc Trang" ${user.getCity() == 'Soc Trang' ? 'selected' : ''}>Soc Trang</option>
                                                        <option value="Son La" ${user.getCity() == 'Son La' ? 'selected' : ''}>Son La</option>
                                                        <option value="Tay Ninh" ${user.getCity() == 'Tay Ninh' ? 'selected' : ''}>Tay Ninh</option>
                                                        <option value="Thai Binh" ${user.getCity() == 'Thai Binh' ? 'selected' : ''}>Thai Binh</option>
                                                        <option value="Thai Nguyen" ${user.getCity() == 'Thai Nguyen' ? 'selected' : ''}>Thai Nguyen</option>
                                                        <option value="Thanh Hoa" ${user.getCity() == 'Thanh Hoa' ? 'selected' : ''}>Thanh Hoa</option>
                                                        <option value="Thua Thien Hue" ${user.getCity() == 'Thua Thien Hue' ? 'selected' : ''}>Thua Thien Hue</option>
                                                        <option value="Tien Giang" ${user.getCity() == 'Tien Giang' ? 'selected' : ''}>Tien Giang</option>
                                                        <option value="TP Ho Chi Minh" ${user.getCity() == 'TP Ho Chi Minh' ? 'selected' : ''}>TP Ho Chi Minh</option>
                                                        <option value="Tra Vinh" ${user.getCity() == 'Tra Vinh' ? 'selected' : ''}>Tra Vinh</option>
                                                        <option value="Tuyen Quang" ${user.getCity() == 'Tuyen Quang' ? 'selected' : ''}>Tuyen Quang</option>
                                                        <option value="Vinh Long" ${user.getCity() == 'Vinh Long' ? 'selected' : ''}>Vinh Long</option>
                                                        <option value="Vinh Phuc" ${user.getCity() == 'Vinh Phuc' ? 'selected' : ''}>Vinh Phuc</option>
                                                        <option value="Yen Bai" ${user.getCity() == 'Yen Bai' ? 'selected' : ''}>Yen Bai</option>
                                                    </select>
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="tab-pane fade" id="email-tab-pane" role="tabpanel" aria-labelledby="email-tab" tabindex="0">
                                            <form action="#!">
                                                <fieldset class="row gy-3 gy-md-0">
                                                    <legend class="col-form-label col-12 col-md-3 col-xl-2">Email Alerts</legend>
                                                    <div class="col-12 col-md-9 col-xl-10">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" id="emailChange">
                                                            <label class="form-check-label" for="emailChange">
                                                                Email Changed
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" id="passwordChange">
                                                            <label class="form-check-label" for="passwordChange">
                                                                Password Changed
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" id="weeklyNewsletter">
                                                            <label class="form-check-label" for="weeklyNewsletter">
                                                                Weekly Newsletter
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" id="productPromotions">
                                                            <label class="form-check-label" for="productPromotions">
                                                                Product Promotions
                                                            </label>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                                <div class="row">
                                                    <div class="col-12">
                                                        <button type="submit" class="btn btn-primary mt-4">Save Changes</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="tab-pane fade" id="password-tab-pane" role="tabpanel" aria-labelledby="password-tab" tabindex="0">
                                            <form action="changePassword" method="Post">
                                                <input type="hidden" name="action" value="change">
                                                <% if (request.getAttribute("error") != null) { %>
                                                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                                                <% } %>
                                                <% if (request.getAttribute("success") != null) { %>
                                                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
                                                <% } %>
                                                <div class="row gy-3 gy-xxl-4">

                                                    <div class="col-12">
                                                        <label for="currentPassword" class="form-label">Current Password</label>
                                                        <input type="password" class="form-control" id="currentPassword" name="old">
                                                    </div>
                                                    <div class="col-12">
                                                        <label for="newPassword" class="form-label">New Password</label>
                                                        <input type="password" class="form-control" id="newPassword" name="new">
                                                    </div>
                                                    <div class="col-12">
                                                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                                                        <input type="password" class="form-control" id="confirmPassword" name="renew">
                                                    </div>
                                                    <div class="col-12">
                                                        <button type="submit" class="btn btn-primary">Change Password</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>

        <!-- Aside -->


        <!-- Footer -->
        <jsp:include page="aside.jsp" />
        <!-- Javascript Files: Vendors -->
        <script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Javascript Files: Controllers -->
        <script src="./assets/controller/console-bsb.js"></script>

        <!-- BSB Body End -->
    </body>
</html>
