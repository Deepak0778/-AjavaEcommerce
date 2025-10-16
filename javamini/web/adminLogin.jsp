<%-- 
    Document   : adminLogin
    Created on : Sep 12, 2025, 1:55:59 AM
    Author     : asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Admin Login</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background: #f2f2f2;
    display: flex;
    height: 100vh;
    justify-content: center;
    align-items: center;
    margin: 0;
  }
  .login-container {
    background: white;
    padding: 2rem;
    border-radius: 6px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    width: 300px;
  }
  h2 {
    text-align: center;
    margin-bottom: 1.5rem;
    color: #333;
  }
  label {
    display: block;
    margin-bottom: 0.3rem;
    color: #555;
    font-size: 0.9rem;
  }
  input[type="email"],
  input[type="password"] {
    width: 100%;
    padding: 0.5rem;
    margin-bottom: 1.2rem;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 1rem;
    box-sizing: border-box;
  }
  input[type="submit"] {
    width: 100%;
    background: #007BFF;
    border: none;
    padding: 0.6rem;
    color: white;
    font-size: 1rem;
    border-radius: 4px;
    cursor: pointer;
  }
  input[type="submit"]:hover {
    background: #0056b3;
  }
</style>
</head>
<body>
  <div class="login-container">
    <h2>Admin Login</h2>
    <form action="AdminLogin" method="GET">
      <label for="email">Email</label>
      <input type="email" id="email" name="email" placeholder="admin@example.com" required />
      
      <label for="password">Password</label>
      <input type="password" id="password" name="password" placeholder="Enter password" required />
      
      <input type="submit" value="Login" />
    </form>
  </div>
</body>
</html>

