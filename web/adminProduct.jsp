<%-- 
    Document   : adminProduct
    Created on : July 1, 2024, 8:32:37 PM
    Author     : Hammo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="products.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .container {
                width: 80%;
                margin: 20px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }
            .header {
                text-align: center;
                margin-bottom: 20px;
            }
            .button-group {
                display: flex;
                justify-content: space-around;
                margin-bottom: 20px;
            }
            .search-container {
                display: flex;
                justify-content: center;
            }
            .search-container input[type="text"] {
                width: 200px;
                padding: 5px;
                margin-right: 10px;
                border: 1px solid #ced4da;
                border-radius: 4px;
            }
            .search-container input[type="submit"] {
                padding: 5px 10px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #dee2e6;
                text-align: center;
            }
            th {
                background-color: #f1f1f1;
            }
            td input[type="text"] {
                width: 100%;
                padding: 5px;
                border: 1px solid #ced4da;
                border-radius: 4px;
            }
            .table-container {
                overflow-x: auto;
            }
            .error-message {
                color: red;
                text-align: center;
            }
            input[type="submit"] {
                padding: 5px 10px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            input[type="submit"].delete {
                background-color: #dc3545;
            }
            .message{
                color:red;
                text-align: center;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management Page</title>
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
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="Create_Product_Page">
                            <input type="submit" value="Create New Product"/>
                        </form> 
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="Product_Management">
                            <input type="submit" value="Product Management"/>
                        </form>
                        <form action="MainController" method="GET" class="search-container">
                            <input type="hidden" name="action" value="Search_Product">
                            <input type="text" name="search" value="${search}" placeholder="Enter product name" />
                            <input type="submit" value="Search"/>
                            <input type="hidden" name="roleID" value="${loginUser.roleID}"/>
                        </form>
                        <form action="MainController" method="POST">
                            <input type="hidden" name="action" value="Logout"/>
                            <input type="submit" value="Logout"/>
                        </form>
                    </div>
                    <c:if test="${not empty requestScope.LIST_PRODUCT}">
                        <p class="message">${requestScope.MESSAGE}</p>
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>NO</th>
                                        <th>Product ID</th>
                                        <th>Product Name</th>
                                        <th>Image</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Status</th>
                                        <th>Update</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${requestScope.LIST_PRODUCT}" varStatus="status">
                                        <tr>
                                            <form action="MainController" method="POST">
                                                <td>${status.count}</td>
                                                <td>
                                                    <input type="text" name="productID" value="${product.productID}" readonly/>
                                                </td>
                                                <td>
                                                    <input type="text" name="productName" value="${product.productName}" />
                                                </td>
                                                <td>
                                                    <input type="text" name="image" value="${product.image}" />
                                                </td>
                                                <td>
                                                    <input type="text" name="price" value="${product.price}" />
                                                </td>
                                                <td>
                                                    <input type="text" name="quantity" value="${product.quantity}" />
                                                </td>
                                                <td>
                                                    <input type="text" name="status" value="${product.status}" />
                                                </td>
                                                <td>
                                                    <input type="hidden" name="action" value="Update_Product" />
                                                    <input type="submit" value="Update" />
                                                    <input type="hidden" name="search" value="${search}"/>
                                                    <input type="hidden" name="roleID" value="${loginUser.roleID}"/>
                                                </td>
                                            </form>
                                            <form action="MainController" method="POST">
                                                <td>
                                                    <input type="hidden" name="action" value="Delete_Product" />
                                                    <input type="hidden" name="productID" value="${product.productID}" />
                                                    <input type="hidden" name="search" value="${search}" />
                                                    <input type="submit" value="Delete" class="delete"/>
                                                </td>
                                            </form>
                                        </tr>
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

