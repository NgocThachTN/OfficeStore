/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import products.ProductDAO;
import shopping.Cart;
import shopping.Product;
import utils.JavaMailUtils;

/**
 *
 * @author Hammo
 */
@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "viewCart.jsp";
    private static final String EMAIL_PATTERN = "^[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            String email = request.getParameter("userEmail");

            //check cart
            if (cart != null) {
                ProductDAO dao = new ProductDAO();
                boolean checkQuantityTotal = false;
                boolean checkUpdateQuantity = false;
                boolean checkCreateNewOrder = false;
                boolean checkCreateNewDetail = false;
                String QuantityErrorMessage = "OOPS ! Something wrong with ";
                int newOrderID = 0;
                int newDetailID = 0;

                //check valid email
                if (Pattern.matches(EMAIL_PATTERN, email)) {
                    //check quantity
                    for (Product product : cart.getCart().values()) {
                        String id = product.getId();
                        int quantity = product.getQuantity();
                        boolean checkQuantity = dao.checkQuantity(id, quantity);
                        if (!checkQuantity) {
                            QuantityErrorMessage += product.getName() + ". ";
                            checkQuantityTotal = true;
                        }
                    }
                    if (checkQuantityTotal) {
                        QuantityErrorMessage += "The quantity of this product you have choosed is larger than the quantity in our stock !";
                        request.setAttribute("CART_MESSAGE", QuantityErrorMessage);
                    } else {

                        //update quantity
                        for (Product product : cart.getCart().values()) {
                            String id = product.getId();
                            int quantity = product.getQuantity();
                            checkUpdateQuantity = dao.updateQuantity(id, quantity);
                            if (!checkUpdateQuantity) {
                                request.setAttribute("CART_MESSAGE", "Fail to update quantity!");
                                break;
                            }
                        }
                        //create new order
                        if (checkUpdateQuantity) {
                            newOrderID = dao.getNewOrderID() + 1;
                            Double total = Double.parseDouble(request.getParameter("total"));
                            String userID = request.getParameter("userID");
                            checkCreateNewOrder = dao.createNewOrder(newOrderID, total, userID);
                            if (!checkCreateNewOrder) {
                                request.setAttribute("CART_MESSAGE", "Fail to create new order!");
                            }
                        }

                        //create new orderDetail
                        if (checkCreateNewOrder) {
                            for (Product product : cart.getCart().values()) {
                                String id = product.getId();
                                int quantity = product.getQuantity();
                                double tmpTotal = product.getPrice() * quantity;
                                checkCreateNewDetail = dao.createNewDetail( tmpTotal, quantity, newOrderID, id);
                                if (!checkCreateNewDetail) {
                                    request.setAttribute("CART_MESSAGE", "Your order has been successfully! Please check your email for a confirmation.");
                                    break;
                                }
                            }
                        }
                        //confirm message and remove cart
                        if (checkUpdateQuantity && checkCreateNewOrder && checkCreateNewDetail) {
                            request.setAttribute("CART_MESSAGE", "ORDERED SUCCESSFULL ! Your Order Number is : " + newOrderID + ". Please check your email for a confirmation.");
                            session.removeAttribute("CART");
                        }
                        url = SUCCESS;
                    }
                    // Build email content
                    StringBuilder emailContent = new StringBuilder();
                    emailContent.append("<p>Thank you for buying our products! Your order is processing with the order ID: ")
                            .append(newOrderID)
                            .append(". Order Details:</p>")
                            .append("<table border='1' cellpadding='5' cellspacing='0'>")
                            .append("<tr>")
                            .append("<th>Product Name</th>")
                            .append("<th>Quantity</th>")
                            .append("<th>Price</th>")
                            .append("<th>Total</th>")
                            .append("</tr>");

                    for (Product product : cart.getCart().values()) {
                        emailContent.append("<tr>")
                                .append("<td>").append(product.getName()).append("</td>")
                                .append("<td>").append(product.getQuantity()).append("</td>")
                                .append("<td>").append(String.format("%.1f VNĐ", product.getPrice())).append("</td>")
                                .append("<td>").append(String.format("%.1f VNĐ", product.getPrice() * product.getQuantity())).append("</td>")
                                .append("</tr>");
                    }

                    emailContent.append("</table>");
                    emailContent.append("<h3>Total Amount: ").append(String.format("%.1f VNĐ", Double.parseDouble(request.getParameter("total")))).append("</h3>");
                    emailContent.append("<p>Wish you having a good day!</p>");

                     // Send the detailed email
                    JavaMailUtils.sendMail(email, "OFFICE STORE - CONFIRM MAIL", emailContent.toString());

                } else {
                    request.setAttribute("CART_MESSAGE", "Please enter a vaild email for checkout!");
                }

            } else {
                request.setAttribute("CART_MESSAGE", "Cart is empty !");
            }
        } catch (Exception e) {
            log("Error at CheckOutController : " + e.toString());
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
