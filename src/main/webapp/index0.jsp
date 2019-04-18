<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:forward page="/emps"></jsp:forward>
<html>
<head>
    <meta charset="utf-8">
    <%
        application.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--引入JQuery--%>
    <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
</body>
</html>
