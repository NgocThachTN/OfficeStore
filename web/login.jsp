<%-- 
    Document   : login
    Created on : May 12, 2024, 1:32:37 PM
    Author     : Hammo
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            form {
                background-color: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                padding: 40px;
                width: 100%;
                max-width: 400px;
                text-align: center;
            }

            h1 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #333333;
            }

            .input-group {
                margin-bottom: 20px;
                text-align: left;
            }

            .input-group label {
                display: block;
                margin-bottom: 5px;
                color: #333333;
                font-weight: bold;
            }

            .input-group input {
                width: 100%;
                padding: 10px;
                border: 1px solid #cccccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .g-recaptcha {
                margin-bottom: 20px;
            }

            .error {
                color: red;
                margin-bottom: 20px;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
            }

            .button {
                flex: 1;
                padding: 10px;
                margin: 5px;
                border: none;
                border-radius: 5px;
                color: white;
                font-weight: bold;
                cursor: pointer;
                font-size: 16px;
            }

            .button-login {
                background-color: #333333;
            }

            .button-create {
                background-color: #666666;
            }

            .button-reset {
                background-color: #cccccc;
                color: #333333;
            }

            .note {
                margin-top: 20px;
                color: #cc0000;
            }
        </style>
        <title>Login Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <form action="MainController" method="POST">
            <h1>Welcome to Office Store</h1>
            <h1 style="color: #999999;">Login</h1>

            <div class="input-group">
                <label for="userID">User ID*</label>
                <input type="text" name="userID" id="userID" placeholder="Enter ID"/>
            </div>

            <div class="input-group">
                <label for="password">Password*</label>
                <input type="password" name="password" id="password" placeholder="Enter password"/>
            </div>

            <script src="https://www.google.com/recaptcha/api.js" async defer></script>
            <div class="g-recaptcha" data-sitekey="6LcADH8pAAAAALmCZ0TCbaLfTn6z6i7yfKGI9PBG"></div>

            <c:if test="${not empty ERROR}">
                <div class="error">${ERROR}</div>
            </c:if>

            <div class="button-group">
                <input type="submit" name="action" value="Login" class="button button-login"/>
                 <input type="hidden" name="action" value="Create_User_Page">
                <input type="submit" name="action" value="Create User" class="button button-create"
                <input type="reset" value="Reset" class="button button-reset"/>
            </div>
             <a href="MainController?action=Top_Page">Top Page</a>
                <b><i>If you don't have an account, click "Create User"!</i></b>
            </div>
        </form>
    </body>
</html>
