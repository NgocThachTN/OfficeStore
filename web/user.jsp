<%-- 
    Document   : user
    Created on : June 28, 2024, 1:27:01 PM
    Author     : Hammo
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            .button-group form {
                margin: 0;
            }

            .button-group input[type="submit"] {
                background-color: #666666;
                color: white;
                font-weight: bold;
                font-size: 100%;
                border: none;
                border-radius: 30px;
                padding: 10px 20px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .button-group input[type="submit"]:hover {
                background-color: #555555;
            }

            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #999999;
                color: white;
            }

            tbody tr:hover {
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>USER INFORMATION</h1>
            <div class="button-group">
                <%-- Go Shopping --%> 
                <form action="MainController">
                    <input type="hidden" name="action" value="Shopping_Page_View">
                    <input type="submit" value="Go Shopping"/>
                </form>
                <%-- LogOut --%> 
                <form action="MainController" method="POST">
                    <input type="submit" name="action" value="Logout"
                           style="background-color: #999999; width: 100px;"/>
                </form>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Role ID</th>
                        <th>Password</th>
                        <th>Address</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty LOGIN_USER}">
                        <tr>
                            <td><c:out value="${sessionScope.LOGIN_USER.userID}"/></td>
                            <td><c:out value="${sessionScope.LOGIN_USER.fullName}"/></td>
                            <td><c:out value="${sessionScope.LOGIN_USER.roleID}"/></td>
                            <td><c:out value="***"/></td>
                            <td><c:out value="${sessionScope.LOGIN_USER.address}"/></td>
                            <td><c:out value="${sessionScope.LOGIN_USER.phone}"/></td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </body>
</html>

