<%-- 
    Document   : registro_exitoso
    Created on : 18/05/2025, 1:24:47 p. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            *{
                margin: 0px;
                padding: 0px;
                font-family: Georgia, 'Times New Roman', Times, serif;
                text-align: center;
            }


            body{

                display: inline-block;
                margin: 70px;
                background: url(../img/Fondo.png);
                background-repeat: no-repeat;
                background-size: 100% 100%;
                background-attachment: fixed;
            }


            h1{
                color: yellow;
                margin-top: 120px;
                font-size: 250%;
            }

            .btn {
                font-size: 200%;
                background-color: green;
                color: black;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <h1>Regitro Exitoso!!!</h1>
        <div class="footer">
            <form action="../Registro.jsp" method="get" autocomplete="off" novalidate>
                <button type="submit" class="btn">Ok</button>
            </form>
        </div>
    </body>
</html>

