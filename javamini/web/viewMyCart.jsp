<%-- 
    Document   : viewMyCart
    Created on : Sep 13, 2025
    Author     : asus
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    // Step 1: Session check
    session = request.getSession(false);
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("user_id");

    // JDBC variables
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String cart = null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        th {
            background: #007bff;
            color: white;
        }
        tr:hover {
            background: #f9f9f9;
        }
        img {
            width: 60px;
            height: auto;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<h2>🛒 My Cart</h2>

<table>
    <thead>
        <tr>
            <th>Image</th>
            <th>Product</th>
            <th>Description</th>
            <th>Price (₹)</th>
        </tr>
    </thead>
    <tbody>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");

            // Step 2: Get cart from user table
            ps = con.prepareStatement("SELECT cart FROM users WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                cart = rs.getString("cart");
            }

            if (cart != null && !cart.trim().isEmpty()) {
                String[] productIds = cart.split(",");

                // Build placeholders manually (?, ?, ?)
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < productIds.length; i++) {
                    sb.append("?");
                    if (i < productIds.length - 1) sb.append(",");
                }
                String placeholders = sb.toString();

                // Step 3: Fetch product details
                String productQuery = "SELECT * FROM products WHERE product_id IN (" + placeholders + ")";
                ps = con.prepareStatement(productQuery);

                for (int i = 0; i < productIds.length; i++) {
                    ps.setInt(i + 1, Integer.parseInt(productIds[i].trim()));
                }

                rs = ps.executeQuery();

                while (rs.next()) {
    %>
        <tr>
            <td><img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>"></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("description") %></td>
            <td>₹<%= rs.getDouble("price") %></td>
        </tr>
    <%
                }
            } else {
                out.println("<tr><td colspan='4'>Your cart is empty.</td></tr>");
            }

        } catch (Exception e) {
            out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
    %>
    </tbody>
</table>
<% if (cart != null && !cart.trim().isEmpty()) { %>
    <div style="text-align:center; margin-top:20px;">
        <a href="placeOrder.jsp">
            <button type="button" style="padding:12px 20px; background:#28a745; border:none; color:white; font-size:16px; border-radius:6px; cursor:pointer;">
                Place Order
            </button>
        </a>
    </div>
<% } %>


</body>
</html>
