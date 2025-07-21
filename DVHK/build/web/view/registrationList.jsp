<%--
    Document   : registrationList
    Created on : Mar 12, 2025, 3:12:19 PM
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./assets/css/console-bsb.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <main id="main">
            <section class="py-3 py-md-4 py-xl-5 bg-light">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <h1 class="h4">Tables</h1>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 fs-7">
                                    <li class="breadcrumb-item"><a class="link-primary text-decoration-none" href="index.html">Home</a></li>
                                    <li class="breadcrumb-item">Cards</li>
                                    <li class="breadcrumb-item active" aria-current="page">Tables</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </section>

            <section class="pb-3 pb-md-4 pb-xl-5 bg-light">
                <div class="container">
                    <div class="row gy-3 gy-md-4">
                        <div class="col-12 ">
                            <div class="card widget-card border-light shadow-sm bg-transparent">
                                <div class="card-body p-4">
                                    <h5 class="card-title widget-card-title mb-4">Registration List</h5>
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger">${error}</div>
                                    </c:if>
                                    <div class="table-responsive card-body">
                                        <table class="table table-bordered table-striped align-middle m-0" id="datatablesSimple">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th style="width: 5%;">Registration ID</th>
                                                    <th style="width: 4%;">ID Card</th>
                                                    <th style="width: 7%;">Full Name</th>
                                                    <th style="width: 7%;">Registration Type</th>
                                                    <th style="width: 5%;">Status</th>
                                                    <th style="width: 15%;">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${list}" var="o">
                                                    <tr>
                                                        <td>${o.getRegistrationID()}</td>
                                                        <td>${o.getIDCard()}</td>
                                                        <td>${o.getFirstName()} ${o.getLastName()}</td>
                                                        <td>${o.getRegistrationType()}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${o.getStatus() == 'Pending'}">
                                                                    <span class="badge bg-warning">Pending</span>
                                                                </c:when>
                                                                <c:when test="${o.getStatus() == 'Approved'}">
                                                                    <span class="badge bg-success">Approved</span>
                                                                </c:when>
                                                                <c:when test="${o.getStatus() == 'Rejected'}">
                                                                    <span class="badge bg-danger">Rejected</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">${o.getStatus()}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <button type="button" class="btn btn-info btn-sm view-btn" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#viewModal"
                                                                    data-id="${o.getRegistrationID()}"
                                                                    data-idcard="${o.getIDCard()}"
                                                                    data-type="${o.getRegistrationType()}"
                                                                    data-status="${o.getStatus()}"
                                                                    data-startdate="${o.getStartDate()}"
                                                                    data-enddate="${o.getEndDate()}"
                                                                    data-relationship="${o.getRelationship()}"
                                                                    data-headofhousehold="${o.getHeadOfHouseholdID()}"
                                                                    data-approvedby="${o.getApprovedBy()}"
                                                                    data-address="${o.getAddress()}"
                                                                    data-city="${o.getCity()}"  
                                                                    data-comments="${o.getComments()}"
                                                                    data-createddate="${o.getCreatedDate()}"
                                                                    data-firstname="${o.getFirstName()}"
                                                                    data-lastname="${o.getLastName()}">
                                                                View
                                                            </button>
                                                            <input type="button" value="Delete" class="btn btn-danger btn-sm"
                                                                   onclick="if (confirm('Are you sure you want to delete this registration?'))
                                                                           location.href = 'setting?action=delete&registrationId=${o.registrationID}'">

                                                            <c:if test="${o.getStatus() == 'Pending'}">
                                                                <input type="button" value="Approve" class="btn btn-success btn-sm approve-btn" 
                                                                       data-registration-id="${o.registrationID}" 
                                                                       data-registration-type="${o.getRegistrationType()}"
                                                                       data-city="${o.getCity()}">
                                                                <input type="button" value="Reject" class="btn btn-danger btn-sm"
                                                                       onclick="location.href = 'setting?action=reject&registrationId=${o.registrationID}'">
                                                            </c:if>
                                                            <c:if test="${o.getStatus() == 'Approved' || o.getStatus() == 'Rejected'}">
                                                                <button type="button" class="btn btn-primary btn-sm notify-btn" 
                                                                        data-bs-toggle="modal" 
                                                                        data-bs-target="#notifyModal"
                                                                        data-id="${o.getRegistrationID()}"
                                                                        data-idcard="${o.getIDCard()}"
                                                                        data-firstname="${o.getFirstName()}"
                                                                        data-lastname="${o.getLastName()}">
                                                                    Send Notification
                                                                </button>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal View -->
                <div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header card-header">
                                <h5 class="modal-title" id="viewModalLabel">Registration Details</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">Registration ID:</label><span id="modalRegistrationId"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">ID Card:</label><span id="modalIdCard"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">Full Name:</label><span id="modalFullName"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">Registration Type:</label><span id="modalRegistrationType"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">Status:</label><span id="modalStatus"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">Start Date:</label><span id="modalStartDate"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">End Date:</label><span id="modalEndDate"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">Relationship:</label><span id="modalRelationship"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">Head of Household ID:</label><span id="modalHeadOfHousehold"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">Approved By:</label><span id="modalApprovedBy"></span></div>
                                    <div class="col-md-12 mb-3"><label class="form-label fw-bold">Address:</label><span id="modalAddress"></span></div>
                                    <div class="col-md-6 mb-3"><label class="form-label fw-bold">City:</label><span id="modalCity"></span></div>
                                    <div class="col-md-12 mb-3"><label class="form-label fw-bold">Comments:</label><span id="modalComments"></span></div>
                                    <div class="col-md-12 mb-3"><label class="form-label fw-bold">Created Date:</label><span id="modalCreatedDate"></span></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Send Notification -->
                <div class="modal fade" id="notifyModal" tabindex="-1" aria-labelledby="notifyModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header card-header">
                                <h5 class="modal-title" id="notifyModalLabel">Send Notification</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12 mb-3"><label class="form-label fw-bold">Registration ID:</label><span id="notifyRegistrationId"></span></div>
                                    <div class="col-md-12 mb-3"><label class="form-label fw-bold">ID Card:</label><span id="notifyIdCard"></span></div>
                                    <div class="col-md-12 mb-3"><label class="form-label fw-bold">Full Name:</label><span id="notifyFullName"></span></div>
                                    <div class="col-md-12 mb-3">
                                        <label class="form-label fw-bold">Notification Message:</label>
                                        <textarea class="form-control" id="notificationMessage" rows="4" placeholder="Enter your notification message here..."></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" id="sendNotificationBtn">Send</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <jsp:include page="aside.jsp" />

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
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

        <!-- Script khởi tạo DataTables -->
        <script>
            $(document).ready(function () {
                $('#datatablesSimple').DataTable();
            });
        </script>

        <!-- Script xử lý Approve và Send Notification -->
        <script>
            $(document).ready(function () {
                var userRoleID = <%= ((Users) session.getAttribute("user")).getRoleID() %>;
                var userCity = '<%= ((Users) session.getAttribute("user")).getCity() %>';

                // Xử lý nút Approve
                $('.approve-btn').on('click', function () {
                    var registrationId = $(this).data('registration-id');
                    var registrationType = $(this).data('registration-type');
                    var registrationCity = $(this).data('city');
                    var button = $(this);

                    // Kiểm tra quyền: Police chỉ duyệt trong cùng City
                    if (userRoleID === 2 && userCity !== registrationCity) {
                        alert('You can only approve registrations in your city: ' + userCity);
                        return;
                    }

                    $.ajax({
                        url: 'setting',
                        type: 'POST',
                        data: {
                            action: 'approve',
                            registrationId: registrationId,
                            registrationType: registrationType
                        },
                        success: function (response) {
                            if (response === 'success') {
                                var statusCell = button.closest('tr').find('td:eq(4)');
                                var actionsCell = button.closest('tr').find('td:eq(5)');
                                statusCell.html('<span class="badge bg-success">Approved</span>');
                                button.siblings('.approve-btn, .btn-danger:not([value="Delete"])').remove();
                                button.remove();

                                var notifyButton = `
                                    <button type="button" class="btn btn-primary btn-sm notify-btn" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#notifyModal"
                                            data-id="${registrationId}"
                                            data-idcard="${actionsCell.find('.view-btn').data('idcard')}"
                                            data-firstname="${actionsCell.find('.view-btn').data('firstname')}"
                                            data-lastname="${actionsCell.find('.view-btn').data('lastname')}">
                                        Send Notification
                                    </button>
                                `;
                                actionsCell.append(notifyButton);
                                alert('Registration approved successfully!');
                            } else {
                                alert('Failed to approve registration: ' + response);
                            }
                        },
                        error: function () {
                            alert('Error occurred while approving registration.');
                        }
                    });
                });

                // Xử lý nút Send Notification
                $(document).on('click', '.notify-btn', function () {
                    var registrationId = $(this).data('id');
                    var idCard = $(this).data('idcard') || 'N/A';
                    var firstName = $(this).data('firstname') || '';
                    var lastName = $(this).data('lastname') || '';
                    var fullName = (firstName + ' ' + lastName).trim() || 'N/A';

                    $('#notifyRegistrationId').text(registrationId);
                    $('#notifyIdCard').text(idCard);
                    $('#notifyFullName').text(fullName);
                    $('#notificationMessage').val('');
                });

                // Xử lý gửi thông báo
                $('#sendNotificationBtn').on('click', function () {
                    var registrationId = $('#notifyRegistrationId').text();
                    var message = $('#notificationMessage').val().trim();
                    var notifyButton = $('.notify-btn[data-id="' + registrationId + '"]');

                    if (!message) {
                        alert('Please enter a notification message.');
                        return;
                    }
                    if (!registrationId) {
                        alert('No registration selected.');
                        return;
                    }

                    $.ajax({
                        url: 'setting',
                        type: 'POST',
                        data: {
                            action: 'sendNotification',
                            registrationId: registrationId,
                            message: message
                        },
                        beforeSend: function () {
                            $('#sendNotificationBtn').prop('disabled', true).text('Sending...');
                        },
                        success: function (response) {
                            if (response === 'success') {
                                alert('Notification sent successfully!');
                                $('#notifyModal').modal('hide');
                                if (notifyButton.length) {
                                    notifyButton.remove();
                                }
                            } else {
                                alert('Failed to send notification: ' + response);
                            }
                        },
                        error: function (xhr, status, error) {
                            alert('Error occurred: ' + xhr.responseText);
                        },
                        complete: function () {
                            $('#sendNotificationBtn').prop('disabled', false).text('Send');
                        }
                    });
                });
            });
        </script>

        <!-- Script xử lý modal View -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var viewButtons = document.getElementsByClassName('view-btn');
                Array.from(viewButtons).forEach(function (button) {
                    button.addEventListener('click', function () {
                        var id = this.getAttribute('data-id');
                        var idcard = this.getAttribute('data-idcard');
                        var type = this.getAttribute('data-type');
                        var status = this.getAttribute('data-status');
                        var startdate = this.getAttribute('data-startdate');
                        var enddate = this.getAttribute('data-enddate');
                        var relationship = this.getAttribute('data-relationship');
                        var headofhousehold = this.getAttribute('data-headofhousehold');
                        var approvedby = this.getAttribute('data-approvedby');
                        var address = this.getAttribute('data-address');
                        var city = this.getAttribute('data-city');
                        var comments = this.getAttribute('data-comments');
                        var createddate = this.getAttribute('data-createddate');
                        var firstname = this.getAttribute('data-firstname');
                        var lastname = this.getAttribute('data-lastname');

                        var fullName = (firstname || '') + ' ' + (lastname || '');
                        if (!firstname && !lastname) fullName = 'N/A';

                        document.getElementById('modalRegistrationId').textContent = id;
                        document.getElementById('modalIdCard').textContent = idcard;
                        document.getElementById('modalFullName').textContent = fullName.trim();
                        document.getElementById('modalRegistrationType').textContent = type;
                        document.getElementById('modalStatus').textContent = status;
                        document.getElementById('modalStartDate').textContent = startdate;
                        document.getElementById('modalEndDate').textContent = enddate;
                        document.getElementById('modalRelationship').textContent = relationship;
                        document.getElementById('modalHeadOfHousehold').textContent = headofhousehold;
                        document.getElementById('modalApprovedBy').textContent = approvedby || 'N/A';
                        document.getElementById('modalAddress').textContent = address || 'N/A';
                        document.getElementById('modalCity').textContent = city || 'N/A';
                        document.getElementById('modalComments').textContent = comments || 'N/A';
                        document.getElementById('modalCreatedDate').textContent = createddate;
                    });
                });
            });
        </script>
    </body>
</html>