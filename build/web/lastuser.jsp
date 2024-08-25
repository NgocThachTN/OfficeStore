<%-- 
    Document   : lastuser
    Created on : Jul 17, 2024, 14:06:35 PM
    Author     : Hammo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Information</title>
    </head>
    <body>
            UserID: ${requestScope.TOP1.userID} </br>
            fullName:${requestScope.TOP1.fullName}</br>
            roleID:${requestScope.TOP1.roleID}
</body>
</html>
