package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import users.UserDAO;
import users.UserDTO;

/**
 *
 * @author Hammo
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String ERROR = "login.jsp";
    private static final String US = "US";
    private static final String US_PAGE = "user.jsp";
    private static final String AD = "AD";
    private static final String AD_PAGE = "admin.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;
        try {
            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
            if (gRecaptchaResponse != null && !gRecaptchaResponse.isEmpty()) {

                String userID = request.getParameter("userID");
                String password = request.getParameter("password");
                UserDAO dao = new UserDAO();
                UserDTO loginUser = dao.checkLogin(userID, password);

                //Validation
                if (loginUser != null) {
                    if (loginUser.isStatus()) { // Check if the user's status is true
                        HttpSession session = request.getSession();
                        session.setAttribute("LOGIN_USER", loginUser);
                        String roleID = loginUser.getRoleID();

                        //phân quyền
                        if (US.equals(roleID)) {
                            url = US_PAGE;
                        } else if (AD.equals(roleID)) {
                            url = AD_PAGE;
                        } else {
                            request.setAttribute("ERROR", "Your role is not supported");
                        }
                    } else {
                        request.setAttribute("ERROR", "Your account is inactive. Please contact the administrator.");
                    }
                } else {
                    request.setAttribute("ERROR", "Incorrect UserID or Password");
                }
            } else {
                request.setAttribute("ERROR", "Tick reCAPTCHA then try again!");
            }
        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
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
