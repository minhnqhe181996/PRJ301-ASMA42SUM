<%-- 
    Document   : aside
    Created on : Mar 12, 2025, 2:48:44 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<style>
    .sidebar-brand {
        display: flex;
        justify-content: center; /* Căn giữa ngang */
        align-items: center; /* Căn giữa dọc */
        width: 100%;
        font-size: 30px; /* Điều chỉnh kích thước chữ */
        font-weight: bold;
    }
</style>
<aside class="bsb-sidebar-1 offcanvas offcanvas-start" tabindex="-1" id="bsbSidebar1" aria-labelledby="bsbSidebarLabel1">
    <div class="offcanvas-header">
        <c:choose>
            <c:when test="${user.getRoleID() == 3}">
                <a class="sidebar-brand text-center w-100 fs-1 fw-bold text-dark text-decoration-none" href="Management">ADMIN</a>
            </c:when>
            <c:when test="${user.getRoleID() == 2}">
                <a class="sidebar-brand text-center w-100 fs-1 fw-bold text-dark text-decoration-none" href="Management">MANAGER</a>
            </c:when>
            <c:when test="${user.getRoleID() == 1}">
                <a class="sidebar-brand text-center w-100 fs-1 fw-bold text-dark text-decoration-none" href="User">USER</a>
            </c:when>
        </c:choose>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body pt-0">
        <hr class="sidebar-divider mb-3">
        <ul class="navbar-nav">
            <!-- Home -->
            <li class="nav-item">
                <c:choose>
                    <c:when test="${user.getRoleID() == 3 || user.getRoleID() == 2}">
                        <a class="nav-link p-3 bg-light rounded" href="Management" role="button">
                            <span class="nav-link-text fw-bold">Trang chủ</span>
                        </a>
                    </c:when>
                    <c:when test="${user.getRoleID() == 1}">
                        <a class="nav-link p-3 bg-light rounded" href="User" role="button">
                            <span class="nav-link-text fw-bold">Trang chủ</span>
                        </a>
                    </c:when>
                </c:choose>
            </li>

            <!-- Menu cho Admin và Police -->
            <c:if test="${user.getRoleID() == 3 || user.getRoleID() == 2}">
                <!-- Quản lý cư dân -->
                <li class="nav-item">
                    <a class="nav-link p-3" data-bs-toggle="collapse" href="#residentManagement" role="button" aria-expanded="false" aria-controls="residentManagement">
                        <div class="nav-link-icon text-primary">
                            <i class="bi bi-ui-radios"></i>
                        </div>
                        <span class="nav-link-text fw-bold">Quản lý cư dân</span>
                    </a>
                    <div class="collapse" id="residentManagement">
                        <ul class="nav flex-column ms-4">
                            <li class="nav-item">
                                <a class="nav-link link-secondary" href="Management?action=add">
                                    <div class="nav-link-icon text-primary-emphasis">
                                        <i class="bi bi-arrow-right-short"></i>
                                    </div>
                                    <span class="nav-link-text">Đăng ký thông tin cư dân</span>
                                </a>
                            </li>
                            <c:if test="${user.getRoleID() == 3}">
                                <li class="nav-item">
                                    <a class="nav-link link-secondary" href="Management?action=inf_user">
                                        <div class="nav-link-icon text-primary-emphasis">
                                            <i class="bi bi-arrow-right-short"></i>
                                        </div>
                                        <span class="nav-link-text">Danh sách người dùng</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link link-secondary" href="Management?action=account">
                                        <div class="nav-link-icon text-primary-emphasis">
                                            <i class="bi bi-arrow-right-short"></i>
                                        </div>
                                        <span class="nav-link-text">Quản lý tài khoản</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </li>

                <!-- Thông tin dữ liệu -->
                <li class="nav-item">
                    <a class="nav-link p-3" data-bs-toggle="collapse" href="#dataTables" role="button" aria-expanded="false" aria-controls="dataTables">
                        <div class="nav-link-icon text-primary">
                            <i class="bi bi-layout-text-window-reverse"></i>
                        </div>
                        <span class="nav-link-text fw-bold">Thông tin dữ liệu</span>
                    </a>
                    <div class="collapse" id="dataTables">
                        <ul class="nav flex-column ms-4">
                            <li class="nav-item">
                                <a class="nav-link link-secondary" href="PermanentRegistrationProcess">
                                    <div class="nav-link-icon text-primary-emphasis">
                                        <i class="bi bi-arrow-right-short"></i>
                                    </div>
                                    <span class="nav-link-text">Duyệt đăng ký</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link link-secondary" href="Management?action=table_citizen">
                                    <div class="nav-link-icon text-primary-emphasis">
                                        <i class="bi bi-arrow-right-short"></i>
                                    </div>
                                    <span class="nav-link-text">Thông tin cư dân</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link link-secondary" href="Management?action=danhsach">
                                    <div class="nav-link-icon text-primary-emphasis">
                                        <i class="bi bi-arrow-right-short"></i>
                                    </div>
                                    <span class="nav-link-text">Danh sách hộ khẩu</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                <!-- Lịch sử -->
                <li class="nav-item">
                    <a class="nav-link p-3" data-bs-toggle="collapse" href="#history" role="button" aria-expanded="false" aria-controls="history">
                        <div class="nav-link-icon text-primary">
                            <i class="bi bi-card-heading"></i>
                        </div>
                        <span class="nav-link-text fw-bold">Lịch sử</span>
                    </a>
                    <div class="collapse" id="history">
                        <ul class="nav flex-column ms-4">
                            <li class="nav-item">
                                <a class="nav-link link-secondary" href="RegistrationHistory">
                                    <div class="nav-link-icon text-primary-emphasis">
                                        <i class="bi bi-arrow-right-short"></i>
                                    </div>
                                    <span class="nav-link-text">Lịch sử duyệt đăng ký</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
            </c:if>
        </ul>
        <hr class="sidebar-divider my-4">
    </div>
</aside>