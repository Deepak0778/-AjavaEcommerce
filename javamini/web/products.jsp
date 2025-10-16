<%-- 
    Document   : products
    Created on : Sep 14, 2025, 10:30:15 AM
    Author     : asus
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Products - MyShop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fafafa;
            margin: 0;
            padding: 0;
        }

        .products-section {
            padding: 50px 5%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .section-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .section-header h2 {
            font-size: 2.5rem;
            color: #333;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .product-card {
            width: 280px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-image {
            width: 100%;
            height: 200px;
            background: #f4f4f4;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-info {
            padding: 20px;
        }

        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #007185;
        }

        .product-description {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 18px;
            font-weight: bold;
            color: #B12704;
            margin-bottom: 15px;
        }

        .view-btn {
            display: inline-block;
            padding: 10px 16px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
        }

        .view-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <section class="products-section">
        <div class="section-header">
            <h2>All Products</h2>
        </div>

        <div class="product-grid">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM products ORDER BY product_id DESC");

                    while (rs.next()) {
            %>
                <div class="product-card">
                    <div class="product-image">
                        <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
                    </div>
                    <div class="product-info">
                        <h3 class="product-title"><%= rs.getString("name") %></h3>
                        <p class="product-description"><%= rs.getString("description") %></p>
                        <div class="product-price">₹<%= rs.getDouble("price") %></div>
                        <a href="viewProduct.jsp?id=<%= rs.getInt("product_id") %>" class="view-btn">View Product</a>
                    </div>
                </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error loading products: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </section>

</body>
</html>

