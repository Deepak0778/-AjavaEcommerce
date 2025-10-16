<%-- 
    Document   : adminAddProduct
    Created on : Sep 12, 2025, 5:05:14 PM
    Author     : asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Session check (only admin can access)
    session = request.getSession(false);
    if (session == null || session.getAttribute("admin_id") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Product - Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
        }
        .container {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
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

        .nav-links li {
            display: inline-block;
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

          /* Responsive: stack links on small screens */
        @media (max-width: 768px) {
            .nav-links {
              flex-direction: column;
              gap: 10px;
            }
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            display: block;
            margin: 10px 0 5px;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #007bff;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
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
<div class="container">
    <h2>Add New Product</h2>
    <form action="AdminAddProduct" method="post">
        <label for="name">Product Name</label>
        <input type="text" name="name" id="name" required>

        <label for="description">Description</label>
        <textarea name="description" id="description" rows="3" required></textarea>

        <label for="price">Price ($)</label>
        <input type="number" step="0.01" name="price" id="price" required>

        <label for="stock">Stock</label>
        <input type="number" name="stock" id="stock" required>

        <label for="image_url">Image URL</label>
        <input type="text" name="imagurl" id="image_url">

        <button type="submit">Add Product</button>
    </form>
</div>

</body>
</html>

