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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
            }

            .navbar {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 1rem 0;
            }

            .navbar-brand {
                font-size: 1.5rem;
                font-weight: 600;
                color: white !important;
            }

            .container {
                margin-top: 2rem;
                margin-bottom: 2rem;
            }

            .page-title {
                color: #2d3748;
                font-weight: 700;
                font-size: 2.5rem;
                margin-bottom: 2rem;
                text-align: center;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }

            .table-wrapper {
                background: white;
                border-radius: 15px;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                padding: 1.5rem;
                margin-bottom: 2rem;
            }

            .fl-table {
                border: none;
            }

            .fl-table th {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.9rem;
                padding: 1rem;
                border: none;
            }

            .fl-table td {
                padding: 1rem;
                vertical-align: middle;
                border: none;
                border-bottom: 1px solid #e2e8f0;
            }

            .form-control {
                border-radius: 8px;
                border: 1px solid #e2e8f0;
            }

            .form-control:focus {
                box-shadow: 0 0 0 3px rgba(102,126,234,0.25);
                border-color: #667eea;
            }

            .btn {
                padding: 0.5rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-danger {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5253 100%);
                border: none;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
            }

            .btn-success {
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                border: none;
            }

            .message {
                background: linear-gradient(135deg, #fff5f5 0%, #fed7d7 100%);
                color: #c53030;
                padding: 1rem;
                border-radius: 10px;
                border: none;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                font-weight: 500;
            }

            .total-amount {
                font-size: 2rem;
                color: #2d3748;
                font-weight: 700;
                text-align: center;
                margin: 2rem 0;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
            }

            .checkout-section {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
            }

            .checkout-form input[type="email"] {
                max-width: 300px;
                margin-right: 1rem;
            }

            @media (max-width: 768px) {
                .d-flex {
                    flex-direction: column;
                    gap: 1rem;
                }
                
                .checkout-form {
                    width: 100%;
                }

                .checkout-form input[type="email"] {
                    margin-bottom: 1rem;
                    max-width: 100%;
                }
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

