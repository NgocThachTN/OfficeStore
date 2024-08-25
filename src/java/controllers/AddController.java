/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;
/**
 *
 * @author Hammo
 */
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
import shopping.*;


/**
 *
 * @author Hammo
 */
@WebServlet(name = "AddController", urlPatterns = {"/AddController"})
public class AddController extends HttpServlet {

    private static final String ERROR="error.jsp";
    private static final String SUCCESS="shopping.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url=ERROR;
        try {
            ProductDAO dao = new ProductDAO();
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String productID = request.getParameter("productID");
            String productName = request.getParameter("productName");
            int price = Integer.parseInt(request.getParameter("price"));
            String image = request.getParameter("image");
            
            String pageIndex = request.getParameter("index");
            if(pageIndex == null){
                pageIndex="1";
            }
            int index = Integer.parseInt(pageIndex);
            int count = dao.getNumberPage();
            int endPage = count / 10;
            if(count % 10 !=0){
                endPage++;
            }
            List<ProductDTO> list = dao.paging(index);
            request.setAttribute("list", list);
            request.setAttribute("endPage", endPage);
 
            HttpSession session = request.getSession();
            if(session!=null){
                Cart cart = (Cart) session.getAttribute("CART");
                if(cart==null){
                    cart=new Cart();
                }
                Product product = new Product(productID, productName, price, quantity);
                        boolean check = cart.add(product);
                if(check){
                    session.setAttribute("CART", cart);
                    request.setAttribute("MESSAGE", "You have already added "+productName+" with quantity  " + quantity);
                    url= SUCCESS;
                }
            }
            
        } catch (Exception e) {
            log("Error at AddController: "+e.toString());
        }finally{
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
