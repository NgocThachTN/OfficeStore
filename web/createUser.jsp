<%-- 
    Document   : createUser
    Created on : June 29, 2024, 2:32:37 PM
    Author     : Hammo
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="users.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New User</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background: #ffffff;
                padding: 20px 40px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 400px;
                text-align: center;
            }
            h1 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #333333;
            }
            input, select {
                width: calc(100% - 20px);
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #dddddd;
                border-radius: 5px;
            }
            input[type="submit"], input[type="reset"] {
                width: 48%;
                margin: 10px 1%;
                background-color: #666666;
                color: white;
                font-weight: bold;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            input[type="submit"]:hover {
                background-color: #555555;
            }
            input[type="reset"] {
                background-color: #cccccc;
            }
            input[type="reset"]:hover {
                background-color: #bbbbbb;
            }
            .error {
                color: red;
                font-size: 12px;
                text-align: left;
                margin: -10px 0 10px 0;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Input Information to Create New User</h1>
            <form action="MainController" method="POST">
                <input type="text" name="userID" required="" placeholder="Enter ID"/> 
                <div class="error">${requestScope.USER_ERROR.userIDError}</div>
                <input type="text" name="fullName" required="" placeholder="Enter Full Name"/>
                <div class="error">${requestScope.USER_ERROR.fullNameError}</div>
                 <input type="text" name="roleID" value="US" readonly=""/>
                <input type="password" name="password" required="" placeholder="Enter Password"/><br>
                <input type="password" name="confirm" required="" placeholder="Confirm Password"/>
                <div class="error">${requestScope.USER_ERROR.confirmError}</div>
                <input type="text" name="address" required="" placeholder="Enter Address"/><br>
                <input type="text" name="phone" required="" placeholder="Enter Phone"/>
                <div class="error">${requestScope.USER_ERROR.phoneError}</div>
                <input type="hidden" name="action" value="Create_User">
                <div class="error">${requestScope.USER_ERROR.error}</div>
                <input type="submit" name="action" value="Create"/>
                <input type="reset" name="Reset" value="Reset"/>
            </form>
        </div>
    </body>
</html>

