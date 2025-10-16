<%-- 
    Document   : adminHome
    Created on : Sep 11, 2025, 5:34:02 PM
    Author     : asus
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*" %>

<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("admin_id") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    int totalUsers = 0;
    int totalProducts = 0;
    int totalOrders = 0;
    ResultSet recentOrders = null;

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");

        // Total users
        Statement stmt1 = con.createStatement();
        ResultSet rs = stmt1.executeQuery("SELECT COUNT(*) AS cnt FROM users");
        if (rs.next()) totalUsers = rs.getInt("cnt");
        rs.close();
        stmt1.close();

        // Total products
        Statement stmt2 = con.createStatement();
        ResultSet pc = stmt2.executeQuery("SELECT COUNT(*) AS cntt FROM products");
        if (pc.next()) totalProducts = pc.getInt("cntt");
        pc.close();
        stmt2.close();

        // Total orders
        Statement stmt3 = con.createStatement();
        ResultSet ro = stmt3.executeQuery("SELECT COUNT(*) AS cnto FROM orders");
        if (ro.next()) totalOrders = ro.getInt("cnto");
        ro.close();
        stmt3.close();

        // Fetch top 4 recent orders
        ps = con.prepareStatement(
            "SELECT o.id AS order_id, u.email, COUNT(o.item_id) AS items_count, SUM(o.price) AS total_amount, o.status " +
            "FROM orders o " +
            "JOIN users u ON o.user_id = u.user_id " +
            "GROUP BY o.id, u.email, o.status " +
            "ORDER BY o.timestamp DESC " +
            "LIMIT 4"
        );
        recentOrders = ps.executeQuery();

    } catch(Exception e){
        out.println("<p style='color:red;text-align:center;'>Error: "+e.getMessage()+"</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        /* Reset */
        * { 
            margin:0; 
            padding:0; 
            box-sizing:border-box; 
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            color: #333;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            padding: 12px 20px;
            color: white;
        }

        .navbar .logo { font-size: 20px; font-weight: bold; }

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

        .nav-links a:hover { color: #ffdd57; }

        /* Container */
        .container { padding: 20px; }

        /* Stats Cards */
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .card h2 { color: #007bff; margin-bottom: 8px; }

        /* Table */
        .table-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        .table-section h2 { margin-bottom: 15px; }

        table { width: 100%; border-collapse: collapse; }

        table th, table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        table th { background-color: #f0f0f0; }

        table tr:hover { background-color: #f9f9f9; }

        /* Status colors */
        .status-pending { color: orange; }
        .status-completed { color: green; }
        .status-cancelled { color: red; }

        @media (max-width:768px){
            .nav-links { flex-direction: column; gap:10px; }
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

    <main class="container">
        <h1>Welcome, Admin 👋</h1>

        <!-- Stats -->
        <section class="stats">
            <div class="card">
                <h2><%= totalUsers %></h2>
                <p>Total Users</p>
            </div>
            <div class="card">
                <h2><%= totalProducts %></h2>
                <p>Total Products</p>
            </div>
            <div class="card">
                <h2><%= totalOrders %></h2>
                <p>Total Orders</p>
            </div>
        </section>

        <!-- Recent Orders -->
        <section class="table-section">
            <h2>Recent Orders</h2>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User</th>
                        <th>Items</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
<%
    if(recentOrders != null){
        while(recentOrders.next()){
            String status = recentOrders.getString("status");
            String statusClass = "status-pending";
            if("Completed".equalsIgnoreCase(status)) statusClass="status-completed";
            else if("Cancelled".equalsIgnoreCase(status)) statusClass="status-cancelled";
%>
                    <tr>
                        <td>#<%= recentOrders.getInt("order_id") %></td>
                        <td><%= recentOrders.getString("email") %></td>
                        <td><%= recentOrders.getInt("items_count") %></td>
                        <td>₹<%= recentOrders.getDouble("total_amount") %></td>
                        <td class="<%= statusClass %>"><%= status %></td>
                    </tr>
<%
        }
    } else {
%>
                    <tr>
                        <td colspan="5" style="text-align:center;">No recent orders</td>
                    </tr>
<%
    }
%>
                </tbody>
            </table>
        </section>
    </main>

<%
    try {
        if(recentOrders != null) recentOrders.close();
        if(ps != null) ps.close();
        if(con != null) con.close();
    } catch(Exception e){}
%>

</body>
</html>
