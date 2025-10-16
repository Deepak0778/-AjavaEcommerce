<%-- 
    Document   : adminAllOrders
    Created on : Sep 14, 2025, 1:15:51 PM
    Author     : asus
--%>

<%-- 
    Document   : adminAllOrders
    Created on : Sep 14, 2025, 1:15:51 PM
    Author     : asus
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*" %>

<%
    // Check if admin is logged in
    session = request.getSession(false);
    if (session == null || session.getAttribute("admin_id") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/javacart", "root", "12345678"
        );

        // Fetch all orders with user and product details
        String query = "SELECT o.id AS order_id, u.email, p.name AS product_name, o.price, o.contact, " +
                       "o.street, o.city, o.state, o.zip_code, o.status, o.timestamp " +
                       "FROM orders o " +
                       "JOIN users u ON o.user_id = u.user_id " +
                       "JOIN products p ON o.item_id = p.product_id " +
                       "ORDER BY o.timestamp DESC";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Orders - Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            padding: 20px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            padding: 12px 20px;
            color: white;
        }

        .navbar .logo {
            font-size: 20px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #ffdd57;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        .status-pending {
            color: orange;
            font-weight: bold;
        }

        .status-completed {
            color: green;
            font-weight: bold;
        }

        .status-cancelled {
            color: red;
            font-weight: bold;
        }

        .btn-edit {
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn-edit:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">MyShop Admin</div>
        <ul class="nav-links">
            <li><a href="adminHome.jsp">Dashboard</a></li>
            <li><a href="adminProducts.jsp">Products</a></li>
            <li><a href="adminAllOrders.jsp">Orders</a></li>
        </ul>
    </nav>

    <h1>All Orders</h1>

    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>User</th>
                <th>Product</th>
                <th>Price</th>
                <th>Contact</th>
                <th>Address</th>
                <th>Status</th>
                <th>Order Time</th>
                <th>Edit</th>
            </tr>
        </thead>
        <tbody>
<%
        while (rs.next()) {
            String address = rs.getString("street") + ", " + rs.getString("city") + ", " +
                             rs.getString("state") + " - " + rs.getString("zip_code");
            String status = rs.getString("status");
            String statusClass = "status-pending";
            if ("Completed".equalsIgnoreCase(status)) statusClass = "status-completed";
            else if ("Cancelled".equalsIgnoreCase(status)) statusClass = "status-cancelled";
%>
            <tr>
                <td><%= rs.getInt("order_id") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("product_name") %></td>
                <td>₹<%= rs.getDouble("price") %></td>
                <td><%= rs.getString("contact") %></td>
                <td><%= address %></td>
                <td class="<%= statusClass %>"><%= status %></td>
                <td><%= rs.getTimestamp("timestamp") %></td>
                <td>
                    <a class="btn-edit" href="adminEditOrder.jsp?orderId=<%= rs.getInt("order_id") %>">Edit</a>
                </td>
            </tr>
<%
        } // end while
%>
        </tbody>
    </table>

<%
    } catch (Exception e) {
        out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>

</body>
</html>
