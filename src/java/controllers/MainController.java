package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends HttpServlet {

    private static final String WELCOME = "login.jsp";

    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "LoginController";

    private static final String CREATE_USER_PAGE = "Create_User_Page";
    private static final String CREATE_USER_PAGE_VIEW = "createUser.jsp";
    
    private static final String PRODUCT_MANAGEMENT_PAGE = "Product_Management";
    private static final String PRODUCT_MANAGEMENT_PAGE_VIEW = "adminProduct.jsp"; 
    
    private static final String CREATE_USER = "Create_User";
    private static final String CREATE_USER_CONTROLLER = "CreateUserController";

    private static final String SEARCH = "Search";
    private static final String SEARCH_CONTROLLER = "SearchController";
    
    private static final String SEARCH_PRODUCT = "Search_Product";
    private static final String SEARCH_PRODUCT_CONTROLLER = "SearchProductController";
    
    private static final String TOP_PAGE="Top_Page";
    private static final String TOP_PAGE_VIEW="SearchTopController"; 
    
    private static final String SEARCH_TOP = "Search_Top";
    private static final String SEARCH_TOP_CONTROLLER = "SearchTopController";
    
    
    private static final String UPDATE = "Update";
    private static final String UPDATE_CONTROLLER = "UpdateController";
    
    private static final String UPDATE_PRODUCT = "Update_Product";
    private static final String UPDATE_PRODUCT_CONTROLLER = "UpdateProductController";
    
    private static final String DELETE = "Delete";
    private static final String DELETE_CONTROLLER = "DeleteController";
    
    private static final String DELETE_PRODUCT = "Delete_Product";
    private static final String DELETE_PRODUCT_CONTROLLER = "DeleteProductController";
    
    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";

    private static final String CREATE_PRODUCT_PAGE = "Create_Product_Page";
    private static final String CREATE_PRODUCT_PAGE_VIEW = "createProduct.jsp";

    private static final String CREATE_PRODUCT = "Create_Product";
    private static final String CREATE_PRODUCT_CONTROLLER = "CreateProductController";

    private static final String SHOPPING_PAGE = "Shopping_Page_View";
    private static final String SHOPPING_PAGE_CONTROLLER = "ViewController";
    
    private static final String ADD = "Add";
    private static final String ADD_CONTROLLER = "AddController";
    
    private static final String VIEW = "View";
    private static final String VIEW_CONTROLLER = "viewCart.jsp";
    
    private static final String REMOVE = "Remove";
    private static final String REMOVE_CONTROLLER = "RemoveController";
    
    private static final String EDIT = "Edit";
    private static final String EDIT_CONTROLLER = "EditController";
    
    private static final String CHECKOUT = "CheckOut";
    private static final String CHECKOUT_CONTROLLER = "CheckOutController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = WELCOME;
        try {
            String action = request.getParameter("action");
            if (LOGIN.equals(action)) {
                url = LOGIN_CONTROLLER;
            } else if (CREATE_USER_PAGE.equals(action)) {
                url = CREATE_USER_PAGE_VIEW;
            } else if (CREATE_USER.equals(action)) {
                url = CREATE_USER_CONTROLLER;
            } else if (SEARCH.equals(action)) {
                url = SEARCH_CONTROLLER;
            } else if (UPDATE.equals(action)) {
                url = UPDATE_CONTROLLER;
            } else if (UPDATE_PRODUCT.equals(action)) {
                url = UPDATE_PRODUCT_CONTROLLER;
            } else if (DELETE.equals(action)) {
                url = DELETE_CONTROLLER;
            } else if (DELETE_PRODUCT.equals(action)) {
                url = DELETE_PRODUCT_CONTROLLER;
            } else if (LOGOUT.equals(action)) {
                url = LOGOUT_CONTROLLER;
            } else if (CREATE_PRODUCT_PAGE.equals(action)) {
                url = CREATE_PRODUCT_PAGE_VIEW;
            } else if (CREATE_PRODUCT.equals(action)) {
                url = CREATE_PRODUCT_CONTROLLER;
            } else if (SHOPPING_PAGE.equals(action)) {
                url = SHOPPING_PAGE_CONTROLLER;
            } else if (ADD.equals(action)) {
                url = ADD_CONTROLLER;
            } else if (VIEW.equals(action)) {
                url = VIEW_CONTROLLER;
            } else if (REMOVE.equals(action)) {
                url = REMOVE_CONTROLLER;
            } else if (EDIT.equals(action)) {
                url = EDIT_CONTROLLER;
            } else if (CHECKOUT.equals(action)) {
                url = CHECKOUT_CONTROLLER;
            } else if (PRODUCT_MANAGEMENT_PAGE.equals(action)) {
                url = PRODUCT_MANAGEMENT_PAGE_VIEW;
            } else if (SEARCH_PRODUCT.equals(action)) {
                url = SEARCH_PRODUCT_CONTROLLER;
            }else if (TOP_PAGE.equals(action)) {
                url = TOP_PAGE_VIEW;
                }else if (SEARCH_TOP    .equals(action)) {
                url = SEARCH_TOP_CONTROLLER;
            }
        } catch (Exception e) {
            log("error at MainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
