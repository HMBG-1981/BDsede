<%-- 
    Document   : Login
    Created on : 29/05/2025, 1:04:11 p. m.
    Author     : Administrador
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Ingreso Usuario</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: url(img/bandera.jpg);
            margin: 0;
            padding: 10px;
        }

        form {
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            max-width: 400px;
            margin: auto;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            border-top: 6px solid #0d6efd;
        }

        h2 {
            text-align: center;
            color: red;
            margin-bottom: 30px;
            font-size: 35px;
            text-shadow:
                -1px -1px 0 black,
                1px -1px 0 black,
                -1px 1px 0 black,
                1px 1px 0 black;
        }

        .form-group {
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            color: #ffffff;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"] {
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
        }

        input[type="submit"] {
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s;
            width: 100%;
            background-color: red;
            color: white;
        }

        input[type="submit"]:hover {
            background-color: #a93030;
        }

        p.mensaje {
            text-align: center;
            font-weight: bold;
            color: yellow;
            text-shadow:
                -1px -1px 0 black,
                1px -1px 0 black,
                -1px 1px 0 black,
                1px 1px 0 black;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Ingreso de Usuario</h2>
    <form action="LoginServlet" method="post">
        <div class="form-group">
            <label for="usuario">Cédula:</label>
            <input type="text" id="usuario" name="usuario" required>
        </div>
        <div class="form-group">
            <label for="contrasena">Contraseña:</label>
            <input type="password" id="contrasena" name="contrasena" required>
        </div>
        <input type="submit" value="Ingresar">
    </form>

    <% 
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null) {
    %>
    <p class="mensaje"><%= mensaje %></p>
    <% } %>
</body>
</html>
