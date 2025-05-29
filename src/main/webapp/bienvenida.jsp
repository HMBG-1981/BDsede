<%-- 
    Document   : bienvenida
    Created on : 29/05/2025, 2:06:41 p. m.
    Author     : Administrador
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String nombre = (String) session.getAttribute("nombre");
%>
<html>
    <head>
        <title>Bienvenida</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: url(img/bandera.jpg);
                margin: 0;
                padding: 10px;
            }

            .container {
                background: linear-gradient(135deg, #0d6efd, #d9534f);
                max-width: 600px;
                margin: auto;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
                border-top: 6px solid #0d6efd;
                text-align: center;
                color: #fff;
            }

            h1 {
                font-size: 40px;
                margin-bottom: 20px;
                text-shadow:
                    -1px -1px 0 black,
                    1px -1px 0 black,
                    -1px 1px 0 black,
                    1px 1px 0 black;
            }

            p {
                font-size: 18px;
                margin-bottom: 30px;
                text-shadow: 1px 1px 2px black;
            }

            .btn-container {
                display: flex;
                justify-content: center;
                gap: 20px;
            }

            .btn {
                background-color: red;
                border: none;
                border-radius: 8px;
                color: white;
                padding: 15px 30px;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s;
                text-decoration: none;
            }

            .btn:hover {
                background-color: #a93030;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>¡Bienvenid@<%= (nombre != null) ? ", " + nombre : "" %>!</h1>
            <p>
                Nos alegra tenerte aquí. Si deseas registrar un nuevo usuario, haz clic en <strong>Registrar</strong>.<br>
                En caso contrario, puedes hacer clic en <strong>Continuar</strong> para acceder a nuestro sistema.
            </p>
            <div class="btn-container">
                <a href="registro_usuarios.jsp" class="btn">Registrar</a>
                <a href="Registro.jsp" class="btn">Continuar</a>
            </div>
        </div>
    </body>
</html>
