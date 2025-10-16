<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fafafa;
            /*padding: 30px;*/
        }
        .product-detail {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .product-detail img {
            width: 100%;
            height: 300px;
            object-fit:contain;
            border-radius: 10px;
        }
        h2 {
            margin-top: 20px;
            color: #333;
        }
        p {
            margin: 10px 0;
            color: #555;
        }
        .price {
            font-size: 22px;
            font-weight: bold;
            color: #B12704;
            margin: 15px 0;
        }
        .btn {
            display: inline-block;
            padding: 12px 20px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }
        .btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />
<%
    String productId = request.getParameter("id"); // fetch ID from URL
    if (productId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM products WHERE product_id = ?");
            ps.setInt(1, Integer.parseInt(productId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
%>
    <div class="product-detail">
        <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
        <h2><%= rs.getString("name") %></h2>
        <p><%= rs.getString("description") %></p>
        <div class="price">₹<%= rs.getDouble("price") %></div>
        <p>Stock: <%= rs.getInt("stock") %></p>
        <a href="AddToCart?id=<%= rs.getInt("product_id") %>" class="btn">Add to Cart</a>
    </div>
<%
            } else {
                out.println("<p>Product not found.</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Invalid request. No product ID provided.</p>");
    }
%>

</body>
</html>
