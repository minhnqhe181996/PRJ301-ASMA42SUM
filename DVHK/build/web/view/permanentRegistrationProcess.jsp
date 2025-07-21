<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registration Process</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
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
            .step-container {
                margin-bottom: 20px;
            }
            .step-header {
                background-color: #f8f9fa;
                padding: 10px;
                border-radius: 5px;
            }
            table th, table td {
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <main class="container my-4">
            <h1 class="mb-4">Registration Process</h1>

            <!-- Step 1: Kiểm tra thông tin công dân -->
            <div class="step-container">
                <div class="step-header"><h4>Step 1: Verify Citizen Information</h4></div>
                <form id="verifyForm" method="post" action="PermanentRegistrationProcess">
                    <input type="hidden" name="action" value="verifyCitizen">
                    <div class="mb-3">
                        <label class="form-label">Citizen ID Card (CCCD/CMND):</label>
                        <input type="text" class="form-control" name="idCard" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Verify Citizen</button>
                </form>
                <c:if test="${not empty verifyResult}">
                    <div class="alert alert-info mt-3">${verifyResult}</div>
                </c:if>
            </div>

            <!-- Step 2: Kiểm tra và phê duyệt yêu cầu -->
            <div class="step-container">
                <div class="step-header"><h4>Step 2: Review and Approve Requests</h4></div>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped" id="requestsTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>ID Card</th>
                                <th>Type</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Address</th>
                                <th>City</th>
                                <th>Relationship</th>
                                <th>Head of Household</th>
                                <th>Approved By</th>
                                <th>Comments</th>
                                <th>Created Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pendingRequests}" var="req">
                                <tr>
                                    <td>${req.registrationID}</td>
                                    <td>${req.IDCard}</td>
                                    <td>${req.registrationType}</td>
                                    <td>${req.startDate}</td>
                                    <td>${req.endDate}</td>
                                    <td>${req.status}</td>
                                    <td>${req.address}</td>
                                    <td>${req.city}</td>
                                    <td>${req.relationship}</td>
                                    <td>${req.headOfHouseholdID}</td>
                                    <td>${req.approvedBy}</td>
                                    <td>${req.comments}</td>
                                    <td>${req.createdDate}</td>
                                    <td>
                                        <button class="btn btn-success btn-sm approve-btn" 
                                                data-id="${req.registrationID}">Approve</button>
                                        <button class="btn btn-danger btn-sm reject-btn" 
                                                data-id="${req.registrationID}">Reject</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <!-- Modal thông báo -->
        <div class="modal fade" id="notificationModal" tabindex="-1" aria-labelledby="notificationModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="notificationModalLabel">Notification</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="notificationMessage">
                        <!-- Nội dung thông báo sẽ được điền bằng JavaScript -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="modalCloseBtn">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal nhập lý do từ chối -->
        <div class="modal fade" id="rejectReasonModal" tabindex="-1" aria-labelledby="rejectReasonModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="rejectReasonModalLabel">Enter Reason for Rejection</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="rejectReasonInput" class="form-label">Reason:</label>
                            <textarea class="form-control" id="rejectReasonInput" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger" id="confirmRejectBtn">Reject</button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="aside.jsp" />
        <!-- Scripts -->


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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#requestsTable').DataTable({
                    "scrollX": true,
                    "pageLength": 10
                });

                // Hàm hiển thị modal thông báo
                function showNotification(message, isSuccess) {
                    $('#notificationMessage').text(message);
                    // Cả thành công và thất bại đều dùng bg-light text-dark
                    $('#notificationModal .modal-content').removeClass('bg-danger text-white').addClass('bg-light text-dark');
                    $('#notificationModal').modal('show');
                }

                // Xử lý nút Approve
                $('.approve-btn').click(function () {
                    var regId = $(this).data('id');
                    $.post('PermanentRegistrationProcess', {action: 'approve', registrationId: regId}, function (response) {
                        if (response === 'success') {
                            showNotification('Approved successfully!', true);
                            setTimeout(function () {
                                location.reload();
                            }, 1500); // Reload sau 1.5s
                        } else {
                            showNotification('Failed to approve: ' + response, false);
                        }
                    });
                });

                // Xử lý nút Reject
                $('.reject-btn').click(function () {
                    var regId = $(this).data('id');
                    $('#rejectReasonModal').modal('show'); // Hiển thị modal nhập lý do

                    // Xử lý khi nhấn nút Confirm trong modal
                    $('#confirmRejectBtn').off('click').on('click', function () {
                        var reason = $('#rejectReasonInput').val().trim();
                        if (reason) {
                            $.post('PermanentRegistrationProcess', {
                                action: 'reject',
                                registrationId: regId,
                                comments: reason
                            }, function (response) {
                                $('#rejectReasonModal').modal('hide'); // Đóng modal nhập lý do
                                if (response === 'success') {
                                    showNotification('Rejected successfully!', true);
                                    setTimeout(function () {
                                        location.reload();
                                    }, 1500); // Reload sau 1.5s
                                } else {
                                    showNotification('Failed to reject: ' + response, false);
                                }
                            });
                            $('#rejectReasonInput').val(''); // Xóa nội dung sau khi gửi
                        } else {
                            showNotification('Please enter a reason for rejection.', false);
                        }
                    });
                });
            });
        </script>
    </body>
</html>