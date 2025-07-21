<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Registration History</title>
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
            .container {
                margin-top: 20px;
            }
            table th, table td {
                white-space: nowrap;
            }
            .status-approved {
                color: green;
                font-weight: bold;
            }
            .status-rejected {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <main class="container">
            <h1 class="mb-4">Registration History</h1>
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="historyTable">
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
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${processedRegistrations}" var="reg">
                            <tr>
                                <td>${reg.registrationID}</td>
                                <td>${reg.IDCard}</td>
                                <td>${reg.registrationType}</td>
                                <td>${reg.startDate}</td>
                                <td>${reg.endDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${reg.getStatus() == 'Pending'}">
                                            <span class="badge bg-warning">Pending</span>
                                        </c:when>
                                        <c:when test="${reg.getStatus() == 'Approved'}">
                                            <span class="badge bg-success">Approved</span>
                                        </c:when>
                                        <c:when test="${reg.getStatus() == 'Rejected'}">
                                            <span class="badge bg-danger">Rejected</span>
                                        </c:when>

                                    </c:choose></td>
                                <td>${reg.address}</td>
                                <td>${reg.city}</td>
                                <td>${reg.relationship}</td>
                                <td>${reg.headOfHouseholdID}</td>
                                <td>${reg.approvedBy}</td>
                                <td>${reg.comments}</td>
                                <td>${reg.createdDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>

        <!-- Scripts -->
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
                $('#historyTable').DataTable({
                    "scrollX": true,
                    "pageLength": 10,
                    "order": [[0, "desc"]] // Sắp xếp theo ID giảm dần (mới nhất trước)
                });
            });
        </script>
    </body>
</html>