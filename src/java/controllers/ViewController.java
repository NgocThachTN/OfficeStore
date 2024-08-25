package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import products.*;

/**
 *
 * @author Hammo
 */

@WebServlet(name = "ViewController", urlPatterns = {"/ViewController"})
public class ViewController extends HttpServlet {

    private static final String ERROR = "user.jsp";
    private static final String SUCCESS = "shopping.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String searchQuery = request.getParameter("search");
            ProductDAO dao = new ProductDAO();
            List<ProductDTO> list;
            
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                list = dao.getListProduct(searchQuery);
            } else {
                String pageIndex = request.getParameter("index");
                if (pageIndex == null) {
                    pageIndex = "1";
                }
                int index = Integer.parseInt(pageIndex);
                int count = dao.getNumberPage();
                int endPage = count / 10;
                if (count % 10 != 0) {
                    endPage++;
                }
                list = dao.paging(index);
                request.setAttribute("endPage", endPage);
            }
            
            request.setAttribute("list", list);
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at ViewController : " + e.toString());
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

