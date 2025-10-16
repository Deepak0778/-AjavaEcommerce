<%-- 
    Document   : placeOrder
    Created on : Sep 14, 2025
    Author     : asus
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Session check
    session = request.getSession(false);
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("user_id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Place Your Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
        }
        .order-form {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background: #28a745;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background: #218838;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="order-form">
    <h2>📝 Place Your Order</h2>
    <form action="PlaceOrder" method="post">
        <!-- Hidden field to pass user ID -->
        <input type="hidden" name="user_id" value="<%= userId %>">

        <label for="contact">Contact Number</label>
        <input type="text" id="contact" name="contact" maxlength="10" required>

        <label for="street">Street</label>
        <input type="text" id="street" name="street" required>

        <label for="city">City</label>
        <input type="text" id="city" name="city" required>

        <label for="state">State</label>
        <input type="text" id="state" name="state" required>

        <label for="zip_code">Zip Code</label>
        <input type="text" id="zip_code" name="zip_code" maxlength="10" required>

        <button type="submit">✅ Confirm Order</button>
    </form>
</div>

</body>
</html>
