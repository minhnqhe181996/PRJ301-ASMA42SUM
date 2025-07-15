<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Request Detail</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { width: 400px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 24px; }
        .detail { margin-bottom: 16px; }
        .label { font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <h2>Request Detail</h2>
    <% model.Request req = (model.Request)request.getAttribute("request"); %>
    <div class="detail"><span class="label">ID:</span> <%= req.getId() %></div>
    <div class="detail"><span class="label">Employee ID:</span> <%= req.getEmployeeId() %></div>
    <div class="detail"><span class="label">Date From:</span> <%= req.getDateFrom() %></div>
    <div class="detail"><span class="label">Date To:</span> <%= req.getDateTo() %></div>
    <div class="detail"><span class="label">Reason:</span> <%= req.getReason() %></div>
    <div class="detail"><span class="label">Status:</span> <%= req.getStatus() %></div>
    <a href="RequestViewController">Back to List</a>
</div>
</body>
</html>
