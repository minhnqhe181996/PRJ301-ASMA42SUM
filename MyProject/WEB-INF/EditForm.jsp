<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Leave Request</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { width: 400px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 24px; }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; }
        input, select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        button { width: 100%; padding: 10px; background: #007bff; color: #fff; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; }
        button:hover { background: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit Leave Request</h2>
    <form method="post" action="EditRequest">
        <input type="hidden" name="id" value="<%= ((model.Request)request.getAttribute("request")).getId() %>" />
        <input type="hidden" name="employeeId" value="<%= ((model.Request)request.getAttribute("request")).getEmployeeId() %>" />
        <div class="form-group">
            <label for="dateFrom">Date From</label>
            <input type="date" id="dateFrom" name="dateFrom" value="<%= ((model.Request)request.getAttribute("request")).getDateFrom() %>" required />
        </div>
        <div class="form-group">
            <label for="dateTo">Date To</label>
            <input type="date" id="dateTo" name="dateTo" value="<%= ((model.Request)request.getAttribute("request")).getDateTo() %>" required />
        </div>
        <div class="form-group">
            <label for="reason">Reason</label>
            <input type="text" id="reason" name="reason" value="<%= ((model.Request)request.getAttribute("request")).getReason() %>" required />
        </div>
        <div class="form-group">
            <label for="status">Status</label>
            <select id="status" name="status">
                <option value="Pending" <%= ((model.Request)request.getAttribute("request")).getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                <option value="Approved" <%= ((model.Request)request.getAttribute("request")).getStatus().equals("Approved") ? "selected" : "" %>>Approved</option>
                <option value="Rejected" <%= ((model.Request)request.getAttribute("request")).getStatus().equals("Rejected") ? "selected" : "" %>>Rejected</option>
            </select>
        </div>
        <button type="submit">Update Request</button>
    </form>
</div>
</body>
</html>
