<%-- 
    Document   : ViewCart
    Created on : June 29, 2024, 1:32:37 PM
    Author     : Hammo
--%>
<%@page import="shopping.Product"%>
<%@page import="shopping.Cart"%>
<%@page import="users.UserDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 50px;
            }
            .table-wrapper {
                box-shadow: 0px 35px 50px rgba(0, 0, 0, 0.2);
                background-color: white;
                border-radius: 5px;
                padding: 20px;
            }
            .fl-table {
                border-collapse: collapse;
                width: 100%;
            }
            .fl-table th, .fl-table td {
                text-align: center;
                padding: 8px;
                border: 1px solid #dddddd;
            }
            .fl-table th {
                background-color: #4CAF50;
                color: white;
            }
            .message {
                padding: 10px;
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
                border-radius: 5px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Office Store</a> 
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
             </div>
        </nav>

        <div class="container">
            <h1 class="text-center my-4">Your Cart</h1>

            <c:choose>
                <c:when test="${empty sessionScope.LOGIN_USER}">
                    <c:redirect url="login.jsp" />
                </c:when>
                <c:otherwise>
                    <c:set var="total" value="0" scope="page" />
                    <c:if test="${not empty requestScope.CART_MESSAGE}">
                        <div class="message text-center">
                            ${requestScope.CART_MESSAGE}
                        </div>
                    </c:if>

                    <c:choose>
                        <c:when test="${not empty sessionScope.CART and not empty sessionScope.CART.cart}">
                            <div class="table-wrapper">
                                <table class="fl-table table table-striped">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th>Remove</th>
                                            <th>Edit</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${sessionScope.CART.cart.values()}" varStatus="status">
                                            <form action="MainController" method="POST">
                                                <tr>
                                                    <td>${status.count}</td>
                                                    <td><input type="text" name="id" value="${product.id}" readonly class="form-control-plaintext"/></td>
                                                    <td>${product.name}</td>
                                                    <td>${product.price} VND</td>
                                                    <td><input type="number" name="quantity" value="${product.quantity}" min="1" required class="form-control"/></td>
                                                    <td>${product.price * product.quantity} VND</td>
                                                    <td><input type="submit" name="action" value="Remove" class="btn btn-danger"/></td>
                                                    <td><input type="submit" name="action" value="Edit" class="btn btn-primary"/></td>
                                                </tr>
                                                <c:set var="total" value="${total + (product.price * product.quantity)}" scope="page"/>
                                            </form>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="text-center my-4">
                                <h2>Total: ${total} VND</h2>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="message text-center">
                                Your cart is empty.
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="d-flex justify-content-between">
                        <form action="MainController" method="get" class="d-inline">
                            <input type="hidden" name="action" value="Shopping_Page_View">
                            <input type="submit" value="Add More" class="btn btn-secondary"/>
                            <input type="hidden" name="roleID" value="${sessionScope.LOGIN_USER.roleID}"/>
                            <input type="hidden" name="searchType" value="ALL"/>
                        </form>

                        <form action="MainController" class="d-inline">
                            <input type="email" name="userEmail" required class="form-control d-inline" placeholder="Enter Your Email To Check Out!"/>
                            <input type="submit" name="action" value="CheckOut" class="btn btn-success"/>
                            <input type="hidden" name="total" value="${total}"/>
                            <input type="hidden" name="userID" value="${sessionScope.LOGIN_USER.userID}"/>
                        </form>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>

