package User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

public class PlaceOrder extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("user_id");

        // Address details from form
        String contact = request.getParameter("contact");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zip = request.getParameter("zip_code");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");

            // Step 1: Fetch cart and existing orders
            ps = con.prepareStatement("SELECT cart, orders FROM users WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            String cart = null;
            String existingOrders = "";
            if (rs.next()) {
                cart = rs.getString("cart");
                if (rs.getString("orders") != null && !rs.getString("orders").trim().isEmpty()) {
                    existingOrders = rs.getString("orders");
                }
            }
            rs.close();
            ps.close();

            if (cart != null && !cart.trim().isEmpty()) {
                String[] productIds = cart.split(",");
                String insertOrder = "INSERT INTO orders (user_id, contact, street, city, state, zip_code, item_id, price, timestamp, status) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
                ps = con.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);

                StringBuilder newOrderIds = new StringBuilder();

                for (String pid : productIds) {
                    int productId = Integer.parseInt(pid.trim());

                    // Step 2a: Check product stock
                    PreparedStatement checkQty = con.prepareStatement("SELECT price, stock FROM products WHERE product_id = ?");
                    checkQty.setInt(1, productId);
                    ResultSet prs = checkQty.executeQuery();

                    if (prs.next()) {
                        int qty = prs.getInt("stock");
                        double price = prs.getDouble("price");

                        if (qty <= 0) {
                            // Skip out-of-stock product
                            prs.close();
                            checkQty.close();
                            continue;
                        }

                        // Step 2b: Insert into orders
                        ps.setInt(1, userId);
                        ps.setString(2, contact);
                        ps.setString(3, street);
                        ps.setString(4, city);
                        ps.setString(5, state);
                        ps.setString(6, zip);
                        ps.setInt(7, productId);
                        ps.setDouble(8, price);
                        ps.setString(9, "Pending");
                        ps.executeUpdate();

                        // Step 2c: Decrement stock
                        PreparedStatement updateQty = con.prepareStatement("UPDATE products SET stock = stock - 1 WHERE product_id = ?");
                        updateQty.setInt(1, productId);
                        updateQty.executeUpdate();
                        updateQty.close();

                        // Step 2d: Collect generated order ID
                        ResultSet genKeys = ps.getGeneratedKeys();
                        if (genKeys.next()) {
                            if (newOrderIds.length() > 0) newOrderIds.append(",");
                            newOrderIds.append(genKeys.getInt(1));
                        }
                        genKeys.close();
                    }

                    prs.close();
                    checkQty.close();
                }

                // Step 3: Append new order IDs to existing ones and clear cart
                if (newOrderIds.length() > 0) {
                    String updatedOrders = existingOrders.isEmpty() ? newOrderIds.toString() : existingOrders + "," + newOrderIds.toString();
                    PreparedStatement ups = con.prepareStatement("UPDATE users SET orders = ?, cart = NULL WHERE user_id = ?");
                    ups.setString(1, updatedOrders);
                    ups.setInt(2, userId);
                    ups.executeUpdate();
                    ups.close();
                }
            }

            // Step 4: Redirect to orders page
            response.sendRedirect("viewMyOrders.jsp");

        } catch (Exception e) {
            response.getWriter().println("Error placing order: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
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
        return "PlaceOrder servlet with stock check and appending orders";
    }
}
