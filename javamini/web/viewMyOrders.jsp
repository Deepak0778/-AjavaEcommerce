<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <style>
        /* General Body */
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
            color: #333;
        }

        /* Table Styles */
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th, td {
            border: 1px solid #aaa;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Status Colors */
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

        /* Responsive */
        @media (max-width: 768px) {
            table {
                width: 100%;
            }
            th, td {
                font-size: 14px;
                padding: 8px;
            }
        }
    </style>
</head>
<body>

<%
    // Session check
    session = request.getSession(false);
    if(session == null || session.getAttribute("user_id") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("user_id");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");

        // Step 1: Get the orders column (comma-separated order IDs) from users table
        ps = con.prepareStatement("SELECT orders FROM users WHERE user_id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        String ordersStr = null;
        if(rs.next()){
            ordersStr = rs.getString("orders");
        }
        rs.close();
        ps.close();

        if(ordersStr != null && !ordersStr.trim().isEmpty()){
            String[] orderIds = ordersStr.split(",");

%>
<jsp:include page="navbar.jsp" />
<h2>My Orders</h2>
<table>
    <tr>
        <th>Order ID</th>
        <th>Product</th>
        <th>Price</th>
        <th>Contact</th>
        <th>Address</th>
        <th>Status</th>
        <th>Order Time</th>
    </tr>

<%
            // Step 2: Loop through each order ID and fetch details in descending order
            for(String oid : orderIds){
                int orderId = Integer.parseInt(oid.trim());

                ps = con.prepareStatement(
                    "SELECT o.id, o.item_id, p.name AS product_name, o.price, o.contact, o.street, o.city, o.state, o.zip_code, o.status, o.timestamp " +
                    "FROM orders o " +
                    "JOIN products p ON o.item_id = p.product_id " +
                    "WHERE o.id = ? " +
                    "ORDER BY o.timestamp DESC"
                );
                ps.setInt(1, orderId);
                rs = ps.executeQuery();

                if(rs.next()){
                    String address = rs.getString("street") + ", " + rs.getString("city") + ", " + rs.getString("state") + " - " + rs.getString("zip_code");
                    String status = rs.getString("status");
                    String statusClass = "status-pending";
                    if("Completed".equalsIgnoreCase(status)) statusClass = "status-completed";
                    else if("Cancelled".equalsIgnoreCase(status)) statusClass = "status-cancelled";
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("product_name") %> (ID: <%= rs.getInt("item_id") %>)</td>
        <td>₹<%= rs.getDouble("price") %></td>
        <td><%= rs.getString("contact") %></td>
        <td><%= address %></td>
        <td class="<%= statusClass %>"><%= status %></td>
        <td><%= rs.getTimestamp("timestamp") %></td>
    </tr>
<%
                }
                rs.close();
                ps.close();
            } // end for
        } else {
%>
<p style="text-align:center;">You have no orders yet.</p>
<%
        }
    } catch(Exception e){
%>
<p style="color:red; text-align:center;">Error fetching orders: <%= e.getMessage() %></p>
<%
    } finally {
        try{ if(rs!=null) rs.close(); } catch(Exception e){}
        try{ if(ps!=null) ps.close(); } catch(Exception e){}
        try{ if(con!=null) con.close(); } catch(Exception e){}
    }
%>
</table>
</body>
</html>
