<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Leave Requests</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { width: 800px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 24px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 24px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #007bff; color: #fff; }
        tr:nth-child(even) { background: #f2f2f2; }
        .action { text-align: center; }
    </style>
</head>
<body>
<div class="container">
    <h2>My Leave Requests</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Date From</th>
            <th>Date To</th>
            <th>Reason</th>
            <th>Status</th>
            <th class="action">Action</th>
        </tr>
        <% java.util.List<model.Request> requests = (java.util.List<model.Request>)request.getAttribute("requests");
           for (model.Request req : requests) { %>
        <tr>
            <td><%= req.getId() %></td>
            <td><%= req.getDateFrom() %></td>
            <td><%= req.getDateTo() %></td>
            <td><%= req.getReason() %></td>
            <td><%= req.getStatus() %></td>
            <td class="action">
                <a href="DetailRequest?id=<%= req.getId() %>">Detail</a>
                <% if (req.getStatus().equals("Pending")) { %>
                | <a href="EditRequest?id=<%= req.getId() %>">Edit</a>
                | <a href="DeleteRequest?id=<%= req.getId() %>" onclick="return confirm('Delete this request?');">Delete</a>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
    <a href="home.jsp">Back to Home</a>
</div>
</body>
</html>
