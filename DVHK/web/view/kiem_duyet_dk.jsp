<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Permanent Registration Process</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <style>
        .step-container { margin-bottom: 20px; }
        .step-header { background-color: #f8f9fa; padding: 10px; border-radius: 5px; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <main class="container my-4">
        <h1 class="mb-4">Permanent Registration Process</h1>

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
            <table class="table table-bordered table-striped" id="requestsTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>ID Card</th>
                        <th>Address</th>
                        <th>City</th>
                        <th>Relationship</th>
                        <th>Head of Household</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pendingRequests}" var="req">
                        <tr>
                            <td>${req.registrationID}</td>
                            <td>${req.IDCard}</td>
                            <td>${req.address}</td>
                            <td>${req.city}</td>
                            <td>${req.relationship}</td>
                            <td>${req.headOfHouseholdID}</td>
                            <td>${req.status}</td>
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
    </main>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#requestsTable').DataTable();

            $('.approve-btn').click(function () {
                var regId = $(this).data('id');
                $.post('PermanentRegistrationProcess', { action: 'approve', registrationId: regId }, function (response) {
                    if (response === 'success') {
                        alert('Approved successfully!');
                        location.reload();
                    } else {
                        alert('Failed to approve: ' + response);
                    }
                });
            });

            $('.reject-btn').click(function () {
                var regId = $(this).data('id');
                var reason = prompt('Enter reason for rejection:');
                if (reason) {
                    $.post('PermanentRegistrationProcess', { action: 'reject', registrationId: regId, comments: reason }, function (response) {
                        if (response === 'success') {
                            alert('Rejected successfully!');
                            location.reload();
                        } else {
                            alert('Failed to reject: ' + response);
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>