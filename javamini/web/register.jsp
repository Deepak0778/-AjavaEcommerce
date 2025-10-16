<%-- 
    Document   : register
    Created on : Sep 10, 2025, 4:00:20 PM
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
                height: 60%;
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
                height: 20%;
                width: 20%;
                border-radius: 10px;
                border:1px solid green;
                background-color: green;
                color: white;
                cursor:pointer;
                padding: 5px;
            }
            .genderinp{
                justify-self: start;
                align-self: start;
                margin-left: 20px;
            }
        </style>
    </head>
    <body>
        <div class="hero">
            <div class="innerform">
                <h1>Register as User</h1>
                <form method="POST" action="UserRegister">
                    <div class="inputelem">
                      <label for="name">Name :</label>
                      <input type="text" placeholder="Enter your name" name="name" required>  
                    </div>
                    <div class="inputelem">
                      <label for="email">Email :</label>
                      <input type="email" placeholder="example@email.com" name="email" required>  
                    </div>
                    <div class="inputelem">
                      <label for="phone">Number :</label>
                      <input type="number" placeholder="Enter phonen no." name="phone" required>  
                    </div>
                    <div class="inputelem">
                       <label for="email">Password :</label>
                       <input type="text" name="password" placeholder="*********" required> 
                    </div>
                    <div class="genderinp">
                        <label for="gender">Gender :</label>
                        Male <input type="radio" value="Male" name="gender"> 
                        Female <input type="radio" value="Female" name="gender"><!-- comment -->
                        Other <input type="radio" value="Other" name="gender">
                    </div>
                    <input type="submit" value="Register" class="btn">
                </form>
            </div>
        </div>
    </body>
</html>
