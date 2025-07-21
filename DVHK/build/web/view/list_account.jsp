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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Console - User Management</title>
        <meta name="description" content="Console is a Free Bootstrap Admin Template.">
        <meta name="author" content="BootstrapBrain">
        <link rel="icon" type="image/png" sizes="512x512" href="./assets/favicon/favicon-512x512.png">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./assets/css/console-bsb.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <section class="py-3 py-md-4 py-xl-5 bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <h1 class="h4">Quản lý tài khoản</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb m-0 fs-7">
                                <li class="breadcrumb-item"><a class="link-primary text-decoration-none" href="Management">Home</a></li>
                                <li class="breadcrumb-item">Tables</li>
                                <li class="breadcrumb-item active" aria-current="page">Quản lý tài khoản</li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <!-- Thông báo thành công hoặc lỗi -->
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>Thành công!</strong> ${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("success"); %>
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Lỗi!</strong> ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("error"); %>
                </c:if>
            </div>
        </section>

        <section class="pb-3 pb-md-4 pb-xl-5 bg-light">
            <div class="container">
                <div class="row gy-3 gy-md-4">
                    <div class="card mb-4">
                        <div class="card-body">
                            <table id="datatablesSimple" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th style="width: 10%;">ID</th>
                                        <th style="width: 15%;">Full Name</th>
                                        <th style="width: 15%;">Email</th>
                                        <th style="width: 10%;">Role</th>
                                        <th style="width: 10%;">Phone</th>
                                        <th style="width: 25%;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${UserDAO.getUserIncludeRole()}" var="o">
                                        <tr>
                                            <td>${o.getIDCard()}</td>
                                            <td>${o.getFirstName()} ${o.getLastName()}</td>
                                            <td>${o.getEmail()}</td>
                                            <td>${o.getRoleName()}</td>
                                            <td>${o.getPhoneNumber()}</td>
                                            <td>
                                                <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" 
                                                        data-bs-target="#viewModal${o.getIDCard()}">
                                                    <i class="bi bi-eye"></i> View
                                                </button>
                                                <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" 
                                                        data-bs-target="#editModal${o.getIDCard()}">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </button>
                                                <a href="Management?action=delete&id=${o.getIDCard()}" class="btn btn-danger btn-sm" 
                                                   onclick="return confirm('Are you sure you want to delete this user?')">
                                                    <i class="bi bi-trash"></i> Delete
                                                </a>
                                            </td>
                                        </tr>
                                        <!-- View Modal -->
                                    <div class="modal fade" id="viewModal${o.getIDCard()}" tabindex="-1" 
                                         aria-labelledby="viewModalLabel${o.getIDCard()}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="viewModalLabel${o.getIDCard()}">
                                                        User Details - ${o.getFirstName()} ${o.getLastName()}
                                                    </h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" 
                                                            aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-6 mb-3"><strong>ID Card:</strong> ${o.getIDCard()}</div>
                                                        <div class="col-md-6 mb-3"><strong>Full Name:</strong> ${o.getFirstName()} ${o.getLastName()}</div>
                                                        <div class="col-md-6 mb-3"><strong>Gender:</strong> ${o.getGender()}</div>
                                                        <div class="col-md-6 mb-3"><strong>City:</strong> ${o.getCity()}</div>
                                                        <div class="col-md-6 mb-3"><strong>Email:</strong> ${o.getEmail()}</div>
                                                        <div class="col-md-6 mb-3"><strong>Role:</strong> ${o.getRoleName()}</div>
                                                        <div class="col-md-6 mb-3"><strong>Phone:</strong> ${o.getPhoneNumber()}</div>
                                                        <div class="col-md-6 mb-3"><strong>Address:</strong> ${o.getAddress()}</div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" 
                                                            data-bs-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Edit Modal -->
                                    <div class="modal fade" id="editModal${o.getIDCard()}" tabindex="-1" 
                                         aria-labelledby="editModalLabel${o.getIDCard()}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="editModalLabel${o.getIDCard()}">
                                                        Edit User - ${o.getFirstName()} ${o.getLastName()}
                                                    </h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" 
                                                            aria-label="Close"></button>
                                                </div>
                                                <form action="EditAccount" method="post">
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <label><strong>ID Card:</strong></label>
                                                                <input type="text" class="form-control" name="idCard" 
                                                                       value="${o.getIDCard()}" readonly>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label><strong>First Name:</strong></label>
                                                                <input type="text" class="form-control" name="firstName" 
                                                                       value="${o.getFirstName()}" readonly>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label><strong>Last Name:</strong></label>
                                                                <input type="text" class="form-control" name="lastName" 
                                                                       value="${o.getLastName()}" readonly>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label><strong>Gender:</strong></label>

                                                                <input type="text" class="form-control" name="gender" 
                                                                       value="${o.getGender()}" readonly>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label><strong>City:</strong></label>
                                                                <input type="text" class="form-control" name="city" 
                                                                       value="${o.getCity()}" readonly>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label><strong>Email:</strong></label>
                                                                <input type="email" class="form-control" name="email" 
                                                                       value="${o.getEmail()}" readonly>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label><strong>Role:</strong></label>
                                                                <select class="form-select" name="roleId" required>
                                                                    <option value="1" ${o.getRoleID() == '1' ? 'selected' : ''}>Citizen</option>
                                                                    <option value="2" ${o.getRoleID() == '2' ? 'selected' : ''}>Police</option>
                                                                    <option value="3" ${o.getRoleID() == '3' ? 'selected' : ''}>Admin</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label><strong>Phone:</strong></label>
                                                                <input type="text" class="form-control" name="phoneNumber" 
                                                                       value="${o.getPhoneNumber()}" required pattern="[0-9]{10,15}"readonly>
                                                            </div>
                                                            <div class="col-md-12 mb-3">
                                                                <label><strong>Address:</strong></label>
                                                                <textarea class="form-control" name="address" readonly>${o.getAddress()}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" 
                                                                data-bs-dismiss="modal">Cancel</button>
                                                        <button type="submit" class="btn btn-primary">Save Changes</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section> 

        <jsp:include page="aside.jsp" />

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
        <script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/controller/console-bsb.js"></script>
        <script>
                                                       $(document).ready(function () {
                                                           $('#datatablesSimple').DataTable();
                                                       });
        </script>
    </body>
</html>