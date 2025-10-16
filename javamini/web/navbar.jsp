<%-- 
    Document   : navbar
    Created on : Sep 10, 2025, 5:29:48 PM
    Author     : asus
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    /* Navigation Styles */
    .navbar {
        background: white;
        padding: 0 5%;
        box-shadow: 0 2px 20px rgba(0,0,0,0.08);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .nav-container {
        max-width: 1400px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 70px;
    }

    .logo {
        font-size: 28px;
        font-weight: 700;
        background: linear-gradient(135deg, #667eea, #764ba2);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .nav-links {
        display: flex;
        list-style: none;
        gap: 40px;
        align-items: center;
    }

    .nav-links a {
        text-decoration: none;
        color: #555;
        font-weight: 500;
        font-size: 15px;
        position: relative;
        transition: all 0.3s ease;
    }

    .nav-links a:hover {
        color: #667eea;
    }

    .nav-links a::after {
        content: '';
        position: absolute;
        bottom: -5px;
        left: 0;
        width: 0;
        height: 2px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        transition: width 0.3s ease;
    }

    .nav-links a:hover::after {
        width: 100%;
    }

    /* Mobile Navigation Styles */
    @media (max-width: 768px) {
        .nav-links {
            gap: 20px;
        }
    }

    @media (max-width: 480px) {
        .navbar {
            padding: 0 20px;
        }
        
        .nav-links {
            gap: 15px;
        }
        
        .nav-links a {
            font-size: 14px;
        }
        
        .logo {
            font-size: 24px;
        }
    }
</style>

<!-- Navigation -->
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">MyShop</div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="products.jsp">Products</a></li>
            <li><a href="userProfile.jsp">Profile</a></li>
        </ul>
    </div>
</nav>