<%-- 
    Document   : userProfile
    Created on : Sep 11, 2025, 6:08:33 PM
    Author     : asus
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page import="javax.servlet.http.*" %>
    
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return; // stop execution after redirect
    }
    
    int userId = (Integer) session.getAttribute("user_id");
    String userName = (String) session.getAttribute("user_name");
    String userEmail = (String) session.getAttribute("user_email");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
        }
        .profile-container {
            max-width: 900px;
            margin: auto;
        }
        .profile-card {
            max-width: 400px;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 10px;
        }
        p {
            font-size: 16px;
            margin: 8px 0;
        }
        .btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 15px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        .btn:hover {
            background: #0056b3;
        }
        .btn-group {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <jsp:include page="navbar.jsp" />

    <div class="profile-container">
        <div class="profile-card">
            <h2>Welcome, <%= userName %> 👋</h2>
            <p><strong>User ID:</strong> <%= userId %></p>
            <p><strong>Email:</strong> <%= userEmail != null ? userEmail : "Not available" %></p>

            <div class="btn-group">
                <a href="viewMyCart.jsp" class="btn">🛒 View My Cart</a>
                <a href="viewMyOrders.jsp" class="btn">📦 View My Orders</a>
                <a href="UserLogout" class="btn">🚪 Logout</a>
            </div>
        </div>
    </div>

</body>
</html>
