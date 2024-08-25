package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import users.*;

/**
 *
 * @author Hammo
 */
@WebServlet(name = "CreateUserController", urlPatterns = {"/CreateUserController"})
public class CreateUserController extends HttpServlet {

    private static final String ERROR = "createUser.jsp";
    private static final String SUCCESS = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserDAO dao = new UserDAO();
        UserError userError = new UserError();
        boolean check = true;

        try {
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String roleID = request.getParameter("roleID");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            boolean status = true; // Default status is true

            if (userID.length() < 2 || userID.length() > 10) {
                userError.setUserIDError("User ID must be in [2,10] !");
                check = false;
            }

            boolean checkDuplicate = dao.checkDuplicate(userID);
            if (checkDuplicate) {
                userError.setUserIDError("User ID already exists !");
                check = false;
            }

            if (fullName.length() < 5 || fullName.length() > 20) {
                userError.setFullNameError("Full name must be in [5,20] !");
                check = false;
            }

            if (!password.equals(confirm)) {
                userError.setConfirmError("Two passwords are not the same ! ");
                check = false;
            }

            if (phone.length() < 9 || phone.length() > 11) {
                userError.setPhoneError("Phone number must be in [9,11] !");
                check = false;
            }

            if (check) {
                UserDTO user = new UserDTO(userID, fullName, roleID, password, address, phone, status);
                boolean checkCreate = dao.create(user);
                if (checkCreate) {
                    url = SUCCESS;
                } else {
                    userError.setError("Unknown error");
                    request.setAttribute("USER_ERROR", userError);
                }
            } else {
                request.setAttribute("USER_ERROR", userError);
            }
        } catch (Exception e) {
            log("Error at CreateController: " + e.toString());
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
