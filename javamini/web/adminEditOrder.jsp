<%-- 
    Document   : adminEditOrder
    Created on : Sep 14, 2025, 1:36:34 PM
    Author     : asus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>

<%
    // Check if admin is logged in
    session = request.getSession(false);
    if(session == null || session.getAttribute("admin_id") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    int orderId = 0;
    if(request.getParameter("orderId") != null){
        orderId = Integer.parseInt(request.getParameter("orderId"));
    } else {
        response.sendRedirect("adminAllOrders.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String email = "";
    String productName = "";
    double price = 0;
    String contact = "";
    String address = "";
    String status = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");

        ps = con.prepareStatement(
            "SELECT o.id, u.email, p.name AS product_name, o.price, o.contact, " +
            "o.street, o.city, o.state, o.zip_code, o.status " +
            "FROM orders o " +
            "JOIN users u ON o.user_id = u.user_id " +
            "JOIN products p ON o.item_id = p.product_id " +
            "WHERE o.id=?"
        );
        ps.setInt(1, orderId);
        rs = ps.executeQuery();

        if(rs.next()){
            email = rs.getString("email");
            productName = rs.getString("product_name");
            price = rs.getDouble("price");
            contact = rs.getString("contact");
            address = rs.getString("street") + ", " + rs.getString("city") + ", " + rs.getString("state") + " - " + rs.getString("zip_code");
            status = rs.getString("status");
        } else {
            response.sendRedirect("adminAllOrders.jsp");
            return;
        }

    } catch(Exception e){
        out.println("<p style='color:red;text-align:center;'>Error: "+e.getMessage()+"</p>");
    } finally {
        try{ if(rs!=null) rs.close(); } catch(Exception e){}
        try{ if(ps!=null) ps.close(); } catch(Exception e){}
        try{ if(con!=null) con.close(); } catch(Exception e){}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Order - Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-container {
            max-width: 600px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        input[readonly], select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        a.back-link {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            color: #007bff;
        }

        a.back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h1>Edit Order</h1>

    <div class="form-container">
        <form action="UpdateOrderDetails" method="post">
            <input type="hidden" name="orderId" value="<%= orderId %>">

            <label>User Email:</label>
            <input type="text" value="<%= email %>" readonly>

            <label>Product Name:</label>
            <input type="text" value="<%= productName %>" readonly>

            <label>Price:</label>
            <input type="text" value="₹<%= price %>" readonly>

            <label>Contact:</label>
            <input type="text" value="<%= contact %>" readonly>

            <label>Address:</label>
            <input type="text" value="<%= address %>" readonly>

            <label>Order Status:</label>
            <select name="status">
                <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Pending</option>
                <option value="Out of Delivery" <%= "Out of Delivery".equals(status) ? "selected" : "" %>>Out of Delivery</option>
                <option value="Delivered" <%= "Delivered".equals(status) ? "selected" : "" %>>Delivered</option>
                <option value="Cancelled" <%= "Cancelled".equals(status) ? "selected" : "" %>>Cancelled</option>
            </select>

            <button type="submit">Update Status</button>
            <br>
            <a class="back-link" href="adminAllOrders.jsp">Back to Orders</a>
        </form>
    </div>

</body>
</html>

