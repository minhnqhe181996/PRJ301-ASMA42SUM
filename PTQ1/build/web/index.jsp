<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="/url" prefix="url" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Demo Custom Tag</title>
        <link rel="stylesheet" href="<url:resolve target='css/style.css'/>">
    </head>
    <body>
        <h2>Test Custom Tag hiển thị context path</h2>
        <img src="<url:resolve target='img/logo.png'/>" alt="Logo" />
    </body>
</html>
