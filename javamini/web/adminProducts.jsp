<%-- 
    Document   : adminProducts
    Created on : Sep 12, 2025, 5:00:40 PM
    Author     : asus
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>


<%
    // Session check
    session = request.getSession(false);
    if (session == null || session.getAttribute("admin_id") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    // JDBC variables
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Products - Admin</title>
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
            background: #007bff;
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
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background: #007bff;
            color: white;
        }
        tr:hover {
            background: #f9f9f9;
        }
        .action-btn {
            padding: 6px 10px;
            margin: 0 4px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
        }
        .edit-btn {
            background: #28a745;
        }
        .delete-btn {
            background: #dc3545;
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

    <h1>All Products</h1>
    <div style="text-align: right; margin: 20px 0;">
        <a href="adminAddProduct.jsp" 
           style="background: #007bff; color: white; padding: 10px 16px; 
                  border-radius: 5px; text-decoration: none; font-weight: bold;">
            + Add Product
        </a>
    </div>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price ($)</th>
                <th>Stock</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM products");

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("product_id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getDouble("price") %></td>
                <td><%= rs.getInt("stock") %></td>
                <td><img src="<%= rs.getString("image_url") %>" alt="Product" width="60"></td>
                <td>
                    <button type="submit" class="action-btn edit-btn">Edit</button>
                    <button type="submit" class="action-btn delete-btn">Delete</button>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='7'>Error loading products: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>

</body>
</html>

