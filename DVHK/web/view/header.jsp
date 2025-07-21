<%-- 
    Document   : header
    Created on : Mar 12, 2025, 2:16:31 PM
    Author     : LENOVO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>/* Đảm bảo dropdown menu có chiều rộng tối đa */
    .dropdown-menu {
        max-width: 300px; /* Điều chỉnh giá trị này theo nhu cầu */
    }

    /* Giới hạn phần hiển thị email */
    .dropdown-item .text-secondary {
        max-width: 100%; /* Đảm bảo không vượt quá container cha */
        white-space: nowrap; /* Ngăn xuống dòng */
        overflow: hidden; /* Ẩn phần vượt quá */
        text-overflow: ellipsis; /* Thêm dấu ba chấm khi bị cắt */
    }

    /* Đảm bảo row và col trong dropdown không bị tràn */
    .dropdown-item .row {
        width: 100%;
    }

    /* Điều chỉnh padding và kích thước ảnh nếu cần */
    .dropdown-item .col-9 {
        overflow: hidden; /* Ngăn tràn nội dung */
    }</style>
<header id="header" class="bg-white border-bottom border-light-subtle sticky-top bsb-tpl-header-sticky">
    <nav class="navbar navbar-expand-md bsb-navbar-3 bsb-tpl-navbar-sticky" data-bsb-sticky-target="#header">
        <div class="container">
            <ul class="navbar-nav">
                <li class="nav-item me-3">
                    <a class="nav-link" href="#!" data-bs-toggle="offcanvas" data-bs-target="#bsbSidebar1" aria-controls="bsbSidebar1">
                        <i class="bi-filter-left fs-3 lh-1"></i>
                    </a>
                </li>
            </ul>
            <c:if test="${user.getRoleID()==3}">
            <a class="navbar-brand" href="Management">
                ADMIN
            </a>
            </c:if>
            <c:if test="${user.getRoleID()==2}">
            <a class="navbar-brand" href="Management">
                MANAGER
            </a>
            </c:if>
            <c:if test="${user.getRoleID()==1}">
            <a class="navbar-brand" href="User">
                USER
            </a>
            </c:if>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#bsbNavbar" aria-controls="bsbNavbar" aria-label="Toggle Navigation">
                <i class="bi bi-three-dots"></i>
            </button>
            <div class="collapse navbar-collapse" id="bsbNavbar">
                <ul class="navbar-nav bsb-dropdown-menu-responsive ms-auto align-items-center">




                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle bsb-dropdown-toggle-caret-disable" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="./assets/img/profile/profile-img-1.jpg" width="60" height="60" class="img-fluid rounded-circle" alt="Ethan Leo">
                        </a>
                        <ul class="dropdown-menu dropdown-menu-md-end bsb-dropdown-animation bsb-fadeIn">
                            <li>
                                <h6 class="dropdown-header fs-7 text-center">${user.getFirstName()} ${user.getLastName()}</h6>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li>
                                <a href="Management" class="dropdown-item" aria-current="true">
                                    <div class="row g-0 align-items-center">
                                        <div class="col-3">
                                            <img src="./assets/img/profile/profile-img-1.jpg" width="55" height="55" class="img-fluid rounded-circle" alt="Ethan Leo">
                                        </div>
                                        <div class="col-9">
                                            <div class="ps-3">
                                                <div class="text-secondary mt-1 fs-7">${user.getEmail()}</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li>
                                <a class="dropdown-item" href="Management?action=viewpr">
                                    <span>
                                        <i class="bi bi-person-fill me-2"></i>
                                        <span class="fs-7">View Profile</span>
                                    </span>
                                </a>
                            </li>
                            
                            
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li>
                                <a class="dropdown-item text-center" href="Logout">
                                    <span>
                                        <span class="fs-7">Log Out</span>
                                    </span>
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>