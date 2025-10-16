<%-- 
    Document   : login
    Created on : Sep 10, 2025, 4:00:06 PM
    Author     : asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body,html{
                height: 100%;
                width: 100%;
            }
            .hero{
                height: 100%;
                width: 100%;
                background-color: #DADADA;
                display:flex;
                align-items: center;
                justify-content: center;
            }
            .innerform{
                height: 50%;
                width: 30%;
                background-color: white;
                border: 2px solid black;
                border-radius:10px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            form{
                width: 100%;
                height: 100%;
                display: flex;
                flex-direction: column;
                padding: 20px;
                align-items: center;
                gap:10px;
            }
            .inputelem{
                width: 90%;
                display: flex;
                flex-direction: column;
                /*align-items: center;*/
            }
            form .inputelem input{
                height: 2rem;
                width: 100%;
                padding: 2px;
                /*border-radius: 10px;*/
            }
            label{
                font-size: 1.5rem;
            }
            .btn{
                height: 10%;
                width: 20%;
                border-radius: 10px;
                border:1px solid green;
                background-color: green;
                color: white;
                cursor:pointer;
            }
        </style>
    </head>
    <body>
        <div class="hero">
            <div class="innerform">
                <h1>Login as User</h1>
                <form action="UserLogin" method="GET">
                    <div class="inputelem">
                      <label for="email">Email :</label>
                      <input type="email" placeholder="example@email.com" name="email" required>  
                    </div>
                    <div class="inputelem">
                       <label for="email">Password :</label>
                       <input type="text" placeholder="*********" name="password" required> 
                    </div>
                    <input type="submit" value="Login" class="btn">
                </form>
            </div>
        </div>
    </body>
</html>
