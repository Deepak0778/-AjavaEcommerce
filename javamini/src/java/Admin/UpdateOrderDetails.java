/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author asus
 */
public class UpdateOrderDetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get parameters from form
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load MySQL driver and connect
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");

            // Prepare SQL update
            String sql = "UPDATE orders SET status = ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Successfully updated
                response.sendRedirect("adminAllOrders.jsp?msg=success");
            } else {
                // Update failed
                response.sendRedirect("adminAllOrders.jsp?msg=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminAllOrders.jsp?msg=error");
        } finally {
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to orders page
        response.sendRedirect("adminAllOrders.jsp");
    }
}
