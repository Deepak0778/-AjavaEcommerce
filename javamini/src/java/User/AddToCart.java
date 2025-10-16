/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package User;

import java.io.IOException;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author asus
 */
public class AddToCart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("user_id");
        String productId = request.getParameter("id"); // product id from query param

        if (productId != null) {
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");

                // Step 1: Get current cart
                ps = con.prepareStatement("SELECT cart FROM users WHERE user_id = ?");
                ps.setInt(1, userId);
                rs = ps.executeQuery();

                String cart = "";
                if (rs.next()) {
                    cart = rs.getString("cart");
                }

                // Step 2: Append new product if not already in cart
                if (cart == null || cart.trim().isEmpty()) {
                    cart = productId;
                } else {
                    String[] ids = cart.split(",");
                    boolean alreadyInCart = false;
                    for (String id : ids) {
                        if (id.trim().equals(productId)) {
                            alreadyInCart = true;
                            break;
                        }
                    }
                    if (!alreadyInCart) {
                        cart += "," + productId;
                    }
                }

                // Step 3: Update cart in DB
                ps = con.prepareStatement("UPDATE users SET cart = ? WHERE user_id = ?");
                ps.setString(1, cart);
                ps.setInt(2, userId);
                ps.executeUpdate();

                // Step 4: Redirect to cart page
                response.sendRedirect("viewMyCart.jsp");

            } catch (Exception e) {
                response.getWriter().println("Error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("product.jsp"); // fallback if no product
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
