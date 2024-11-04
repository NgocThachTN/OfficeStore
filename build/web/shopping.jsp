<%-- 
    Document   : shopping
    Created on : June 17, 2024, 12:32:37 AM
    Author     : Hammo
--%>
<%@page import="products.ProductDAO"%>
<%@page import="java.util.Map"%>
<%@page import="users.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="products.ProductDTO"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Shopping Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f2f5;
            color: #1a1a1a;
        }

        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
        }

        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            text-align: center;
        }

        header h1 {
            font-weight: 700;
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .product-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.2s;
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-card img {
            height: 200px;
            object-fit: cover;
        }

        .card-body {
            padding: 1.5rem;
        }

        .card-title {
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .card-text {
            color: #4a5568;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .add-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            border: none !important;
            color: white !important;
            font-weight: 500;
            padding: 0.5rem 1.5rem;
            transition: opacity 0.2s;
        }

        .add-button:hover {
            opacity: 0.9;
        }

        .form-select {
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }

        .pagination-container {
            margin-top: 2rem;
            margin-bottom: 3rem;
        }

        .pagination-container .btn {
            margin: 0 0.2rem;
            border-radius: 8px;
            min-width: 40px;
            height: 40px;
            line-height: 40px;
            padding: 0;
            font-weight: 500;
            transition: all 0.2s;
        }

        .pagination-container .btn:hover {
            background-color: #667eea;
            color: white;
        }

        .center {
            background-color: rgba(255,255,255,0.9);
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 2rem;
            font-size: 1.2rem;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .product-card img {
                height: 180px;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <c:choose>
        <c:when test="${empty sessionScope.LOGIN_USER}">
            <c:redirect url="login.jsp" />
        </c:when>
        <c:otherwise>
            <c:set var="loginUser" value="${sessionScope.LOGIN_USER}" />
            <c:set var="search" value="${param.search}" />
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid"> 
                    <a class="navbar-brand" href="#">Office Store, Welcome: ${loginUser.fullName}</a> 
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item me-2">
                                <form action="MainController" method="get" class="d-flex"> 
                                    <input type="text" name="search" value="${search}" placeholder="Enter product's name" class="form-control me-2" />
                                    <input type="hidden" name="action" value="Search" />
                                    <input type="hidden" name="roleID" value="${loginUser.roleID}" />
                                    <button type="submit" class="btn btn-primary">Search</button>
                                </form>
                            </li>
                            <li class="nav-item me-2">
                                <form action="MainController" class="d-inline-block">
                                    <input type="hidden" name="action" value="View" />
                                    <button type="submit" class="btn btn-secondary">View Cart</button>
                                </form>
                            </li>
                            <li class="nav-item">
                                <form action="MainController" method="POST" class="d-inline-block">
                                    <button type="submit" name="action" value="Logout" class="btn btn-secondary">Logout</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <header>
                <h1>Welcome To Office Store</h1>
            </header>
            
            <div class="row">
                <div class="center">
                    <c:out value="${requestScope.MESSAGE}" />
                </div>  
                <div class="row">
            </div>  
            <div class="container py-4">
                <div class="row g-4">
                    <c:if test="${not empty requestScope.list}">
                        <c:forEach var="product" items="${requestScope.list}">
                            <c:if test="${product.status && product.quantity > 0}">
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="card product-card">
                                        <img src="${product.image}" alt="Product picture" class="card-img-top">
                                        <div class="card-body">
                                            <h5 class="card-title">${product.productName}</h5>
                                            <p class="card-text">Price: ${product.price} VND</p>
                                            <form action="MainController">
                                                <div class="input-group mb-3">
                                                    <select name="quantity" class="form-select">
                                                        <option value="1">1</option>
                                                        <option value="2">2</option>
                                                        <option value="3">3</option>
                                                        <option value="4">4</option>
                                                        <option value="5">5</option>
                                                        <option value="10">10</option>
                                                    </select>
                                                    <input type="hidden" name="productID" value="${product.productID}">
                                                    <input type="hidden" name="productName" value="${product.productName}">
                                                    <input type="hidden" name="price" value="${product.price}">
                                                    <input type="hidden" name="image" value="${product.image}">
                                                    <button type="submit" name="action" value="Add" class="btn btn-outline-secondary add-button">Add</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="pagination-container d-flex justify-content-center">
                    <c:forEach begin="1" end="${endPage}" var="index">
                        <a href="ViewController?index=${index}" class="btn btn-light btn-sm m-1">${index}</a>
                    </c:forEach>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>    
</body>
</html>





