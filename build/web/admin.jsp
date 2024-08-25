<%-- 
    Document   : amdin
    Created on : June 12, 2024, 20:12:50 PM
    Author     : Hammo
--%>
<%@page import="users.UserDTO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 90%;
                margin: auto;
                overflow: hidden;
            }
            .header {
                background-color: #343a40;
                color: #fff;
                padding: 10px 0;
                text-align: center;
            }
            .button-group {
                display: flex;
                justify-content: space-between;
                margin: 20px 0;
            }
            .button-group form {
                margin: 0 10px;
            }
            .button-group input[type="submit"] {
                background-color: #007bff;
                color: white;
                font-weight: bold;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .button-group input[type="submit"]:hover {
                background-color: #0056b3;
            }
            .search-container input[type="text"] {
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                width: 300px;
                margin-right: 10px;
            }
            .table-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            table, th, td {
                border: 1px solid #dee2e6;
            }
            th, td {
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #343a40;
                color: #fff;
            }
            td input[type="text"] {
                width: 90%;
                padding: 5px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                text-align: center;
            }
            td input[type="submit"] {
                background-color: #ffc107;
                color: white;
                border: none;
                border-radius: 5px;
                padding: 5px 10px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            td input[type="submit"]:hover {
                background-color: #e0a800;
            }
            .error-message {
                color: red;
                text-align: center;
            }
            .message{
                color: red;
                text-align:center;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
    </head>
    <body>
        <div class="container">
            <c:choose>
                <c:when test="${empty sessionScope.LOGIN_USER || sessionScope.LOGIN_USER.roleID != 'AD'}">
                    <c:redirect url="login.jsp" />
                </c:when>
                <c:otherwise>
                    <c:set var="loginUser" value="${sessionScope.LOGIN_USER}" />
                    <c:set var="search" value="${param.search != null ? param.search : ''}" />
                    <div class="header">
                        <h1>WELCOME: ${loginUser.fullName}</h1>
                    </div>
                    <div class="button-group">
                        <form action="MainController">
                            <input type="hidden" name="action" value="Create_User_Page">
                            <input type="submit" value="Create new user"/>
                        </form> 
                        <form action="MainController">
                            <input type="hidden" name="action" value="Product_Management">
                            <input type="submit" value="Product Management"/>
                        </form>
                        <form action="MainController" method="GET" class="search-container">
                             <input type="hidden" name="action" value="Search">
                            <input type="text" name="search" value="${search}" placeholder="Enter user's name" />
                            <input type="submit" value="Search"/>
                            <input type="hidden" name="roleID" value="${loginUser.roleID}"/>
                        </form>
                        <form action="MainController" method="POST">
                            <input type="submit" name="action" value="Logout"/>
                        </form>
                    </div>
                    <c:if test="${not empty requestScope.LIST_USER}"> 
                        <p class="message">${requestScope.MESSAGE}</p>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>NO</th>
                                        <th>User ID</th>
                                        <th>Full Name</th>
                                        <th>Role</th>
                                        <th>Address</th>
                                        <th>Phone</th>
                                        <th>Status</th>
                                        <th>Update</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${requestScope.LIST_USER}" varStatus="status">
                                        <form action="MainController" method="POST">
                                            
                                            <tr>
                                                <td>${status.count}</td>
                                                <td>
                                                    <input type="text" name="userID" value="${user.userID}" readonly/>
                                                </td>
                                                <td>
                                                    <input type="text" name="fullName" value="${user.fullName}" />
                                                </td>
                                                <td>
                                                    <input type="text" name="roleID" value="${user.roleID}" />
                                                </td>
                                                <td>
                                                    <input type="text" name="address" value="${user.address}" />
                                                </td>
                                                <td>
                                                    <input type="text" name="phone" value="${user.phone}" />
                                                </td>
                                                <td>
                                                    <input type="text" name="status" value="${user.status}" />
                                                </td>
                                                <!--update-->
                                                <td> 
                                                    <input type="submit" name="action" value="Update" />
                                                    <input type="hidden" name="search" value="${search}"/>
                                                    <input type="hidden" name="roleID" value="${loginUser.roleID}"/>
                                                </td>
                                                <!--delete-->
                                                <td>
                                                    <input type="hidden" name="action" value="Delete" />
                                                    <input type="hidden" name="userID" value="${user.userID}" />
                                                    <input type="hidden" name="search" value="${search}" />
                                                    <input type="submit" value="Delete" />
                                                </td>
                                            </tr>
                                        </form>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${not empty requestScope.ERROR}">
                        <p class="error-message">${requestScope.ERROR}</p>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>

