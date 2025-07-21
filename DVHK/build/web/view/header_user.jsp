<%-- 
    Document   : header_user
    Created on : Mar 13, 2025, 11:15:11 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<div id="spinner"
     class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Loading...</span>
    </div>
</div>
<div class="container-fluid">
    <nav class="navbar navbar-expand-lg fixed-top navbar-light bg-white shadow-sm px-4 px-lg-5 py-3 py-lg-0">


        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="fa fa-bars"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-0">
                <a href="User" class="nav-item nav-link active">Trang chủ</a>

                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Dịch vụ công</a>
                    <div class="dropdown-menu rounded-3 shadow border-0">
                        <a href="User?action=tr" class="dropdown-item">Đăng ký tạm trú</a>
                        <a href="User?action=pr" class="dropdown-item">Đăng ký thường trú</a>
                        <a href="User?action=lt" class="dropdown-item">Khai báo lưu trú</a>

                    </div>
                </div>

                <a href="Notification?action=thongbao" class="nav-item nav-link">Thông Báo</a>
                <a href="HistoryUser?action=lichsu" class="nav-item nav-link">Lịch sử</a>
            </div>

            <ul class="navbar-nav ">
                <li>
                    <a class="nav-link bsb-dropdown-toggle-caret-disable" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="./assets/img/profile/profile-img-1.jpg" width="60" height="60" class="img-fluid rounded-circle" alt="Ethan Leo">
                    </a>
                    <ul class="dropdown-menu dropdown-menu-md-end bsb-dropdown-animation bsb-fadeIn me-5 "style="padding-left:15px; padding-right: 15px">
                        <li>
                            <h6 class="dropdown-header fs-7 text-center">${user.getFirstName()} ${user.getLastName()}</h6>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a href="User" class="dropdown-item" aria-current="true">
                                <div class="row g-0 align-items-center">
                                    <div class="col-3">
                                        <img src="./assets/img/profile/profile-img-1.jpg" width="55" height="55" class="img-fluid rounded-circle" alt="Ethan Leo">
                                    </div>
                                    <div class="col-9">
                                        <div class="ps-3">
                                            <% Users user = (Users)(session.getAttribute("user")); %>
                                            <div class=" mt-1 fs-7"><%= user.getEmail() %></div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item" href="User?action=viewpr">
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
    </nav>
</div>