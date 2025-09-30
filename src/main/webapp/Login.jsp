<%-- 
    Document   : Login
    Created on : 29/05/2025, 1:04:11 p. m.
    Author     : Administrador
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ingreso Usuario</title>

    <!-- Vista adaptable en móviles -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        /* Estilo base */
        body {
            font-family: 'Segoe UI', sans-serif;
            background: url('img/Fondo.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: center;
            align-items: center;
        }

        h2 {
            text-align: center;
            color: red;
            margin-bottom: 20px;
            font-size: 2rem;
            text-shadow:
                -1px -1px 0 black,
                1px -1px 0 black,
                -1px 1px 0 black,
                1px 1px 0 black;
        }

        /* Contenedor del formulario */
        form {
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            width: 90%;
            max-width: 400px;
            padding: 30px 25px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            border-top: 6px solid #0d6efd;
            box-sizing: border-box;
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
            font-size: 1rem;
        }

        input[type="text"],
        input[type="password"] {
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            font-size: 1rem;
            outline: none;
            transition: border 0.2s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #198754;
            box-shadow: 0 0 5px rgba(25, 135, 84, 0.4);
        }

        input[type="submit"] {
            padding: 12px;
            font-size: 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            background-color: red;
            color: white;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: green;
            transform: scale(1.03);
        }

        /* Mensaje dinámico */
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
            font-size: 1rem;
        }

        footer {
            margin-top: 30px;
            font-size: 0.85rem;
            color: red;
            text-align: center;
            text-shadow: 1px 1px 0 black;
        }

        .copyright-logo {
            width: 18px;
            vertical-align: middle;
        }

        /* 🔹 Adaptaciones para pantallas pequeñas */
        @media (max-width: 480px) {
            h2 {
                font-size: 1.6rem;
            }

            form {
                padding: 20px;
                border-radius: 10px;
            }

            label {
                font-size: 0.95rem;
            }

            input[type="text"],
            input[type="password"],
            input[type="submit"] {
                font-size: 0.95rem;
            }
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

    <footer>
        <img src="img/pngegg.png" alt="Copyright" class="copyright-logo">
        <b>2024. Todos los derechos reservados. BDsede V1.0.0</b>
    </footer>

</body>
</html>
