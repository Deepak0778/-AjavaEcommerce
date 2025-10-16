<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyShop - Premium Shopping Experience</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            background: #fafafa;
            color: #333;
            line-height: 1.6;
        }

        /* Top Notification Banner */
        .top-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 12px 0;
            font-size: 14px;
            font-weight: 500;
            position: sticky;
            top: 0;
            z-index: 1001;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        /* Navigation */
        .navbar {
            background: white;
            padding: 0 5%;
            box-shadow: 0 2px 20px rgba(0,0,0,0.08);
            position: sticky;
            top: 48px;
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

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9)), 
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="%23ffffff" stroke-width="0.5" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            padding: 100px 5% 80px;
            text-align: center;
            color: white;
        }

        .hero-content {
            max-width: 800px;
            margin: 0 auto;
        }

        .hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            opacity: 0;
            animation: fadeInUp 1s ease forwards 0.3s;
        }

        .hero p {
            font-size: 1.3rem;
            margin-bottom: 40px;
            opacity: 0.9;
            font-weight: 300;
            opacity: 0;
            animation: fadeInUp 1s ease forwards 0.6s;
        }

        .cta-button {
            display: inline-block;
            background: white;
            color: #667eea;
            padding: 18px 40px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            opacity: 0;
            animation: fadeInUp 1s ease forwards 0.9s;
        }

        .cta-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }

        /* Products Section */
        .products-section {
            padding: 100px 5% 80px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .section-header {
            text-align: center;
            margin-bottom: 70px;
        }

        .section-header h2 {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }

        .section-header p {
            font-size: 1.1rem;
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }

        .product-grid {
            display: flex;              /* instead of grid */
            flex-wrap: wrap;            /* wrap to next row */
            justify-content: center;    /* center align */
            gap: 20px;                  /* spacing between cards */
        }

        .product-card {
            width: 280px;               /* fixed width for consistency */
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            transition: all 0.4s ease;
            position: relative;
        }


        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
        }

        .product-image {
            width: 100%;
            height: 200px; /* fixed height */
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f4f4f4; /* fallback bg if no image */
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* keeps aspect ratio, fills box */
            border-bottom: 1px solid #eee;
        }


        .product-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }

        .product-card:hover .product-image::before {
            left: 100%;
        }

        .product-info {
            padding: 30px;
        }

        .product-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .product-description {
            color: #666;
            margin-bottom: 15px;
            font-size: 0.85rem;
            line-height: 1.5;
        }

        .product-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 15px;
        }

        .add-to-cart {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            font-size: 13px;
            text-decoration: none;
        }

        .add-to-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }
            
            .hero p {
                font-size: 1.1rem;
            }
            
            .section-header h2 {
                font-size: 2.2rem;
            }
            
            .product-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }
        }

        @media (max-width: 480px) {
            .hero {
                padding: 80px 20px 60px;
            }
            
            .products-section {
                padding: 60px 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>Premium Shopping Experience</h1>
            <p>Discover curated products that elevate your lifestyle. Quality meets style in every purchase.</p>
            <a href="#products" class="cta-button">Shop Now</a>
        </div>
    </section>

    <!-- Products Section -->
    <section class="products-section" id="products">
        <div class="section-header">
            <h2>Our Latest Product</h2>
            <p>Handpicked items that represent the perfect blend of quality, style, and innovation</p>
        </div>
        
        <div class="product-grid">
            <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = null;
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javacart", "root", "12345678");
                Statement stmt = null;
                stmt = con.createStatement();
                ResultSet rs = null;
                rs = stmt.executeQuery("SELECT * FROM products ORDER BY product_id DESC LIMIT 3");

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
                    <a href="viewProduct.jsp?id=<%= rs.getInt("product_id") %>" class="add-to-cart">View Product</a>
                </div>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='7'>Error loading products: " + e.getMessage() + "</td></tr>");
            }
        %>
        </div>
    </section>
</body>
</html>