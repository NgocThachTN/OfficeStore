package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import products.ProductDAO;
import products.ProductDTO;
/**
 *
 * @author Hammo
 */
@WebServlet(name = "SearchProductController", urlPatterns = {"/SearchProductController"})
public class SearchProductController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String ADMIN_PAGE = "adminProduct.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String search = request.getParameter("search");
            ProductDAO dao = new ProductDAO();
            String roleID = request.getParameter("roleID");
            HttpSession session = request.getSession();
            if ("AD".equals(roleID)) {
                List<ProductDTO> listProduct = dao.getListProduct(search);
                if (listProduct != null && !listProduct.isEmpty()) {
                    request.setAttribute("MESSAGE", "You are searching products: " + search);
                    request.setAttribute("LIST_PRODUCT", listProduct);
                    url = ADMIN_PAGE;
                } else {
                    request.setAttribute("ERROR", "No products found for: " + search);
                    url = ADMIN_PAGE;
                }
            }
        } catch (Exception e) {
            log("Error at SearchProductController: " + e.toString());
            request.setAttribute("ERROR", "An error occurred while searching for products. Please try again.");
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
