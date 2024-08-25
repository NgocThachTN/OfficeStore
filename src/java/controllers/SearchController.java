package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import products.*;
import users.*;

/**
 *
 * @author Hammo
 */
@WebServlet(name = "SearchController", urlPatterns = {"/SearchController"})
public class SearchController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String US = "US";
    private static final String AD = "AD";
    private static final String AD_ERROR = "admin.jsp";
    private static final String AD_SUCCESS = "admin.jsp";

    private static final String US_ERROR = "ViewController";
    private static final String US_SUCCESS = "ViewController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String search = request.getParameter("search");
            String roleID = request.getParameter("roleID");
            HttpSession session = request.getSession();
            UserDAO userDAO = new UserDAO();
            ProductDAO productDAO = new ProductDAO();
            if (AD.equals(roleID)) {
                List<UserDTO> listUser = userDAO.getListUser(search);
                if (listUser.size() > 0) {
                    request.setAttribute("MESSAGE", "You are searching for users: " + search);
                    request.setAttribute("LIST_USER", listUser);
                    url = AD_SUCCESS;
                } else {
                    request.setAttribute("ERROR", "No users found for: " + search + ". Please try again!");
                    url = AD_ERROR;
                }
            }
            if (US.equals(roleID)) {
                url = US_ERROR;
                List<ProductDTO> listProduct = productDAO.getListProduct(search);
                if (listProduct.size() > 0) {
                    request.setAttribute("MESSAGE", "You are searching: " + search);
                    session.setAttribute("LIST_PRODUCT", listProduct);
                    url = US_SUCCESS;
                } else {
                    session.setAttribute("LIST_PRODUCT", listProduct);
                    request.setAttribute("ERROR", "An error occurred while searching for products " + search + " .Please try again!");
                    url = US_ERROR;
                }
            }
        } catch (Exception e) {
            log("Error at SearchController: " + e.toString());
            request.setAttribute("ERROR_MESSAGE", "An error occurred while searching for products. Please try again.");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
