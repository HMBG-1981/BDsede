<%-- 
    Document   : bienvenida
    Created on : 29/05/2025, 2:06:41 p. m.
    Author     : Administrador
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String nombre = (String) session.getAttribute("nombre");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenida</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: url('img/Fondo.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .container {
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            width: 90%;
            max-width: 600px;
            padding: 40px 25px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            border-top: 6px solid #0d6efd;
            text-align: center;
            color: #fff;
        }

        h1 {
            font-size: 2.2rem;
            margin-bottom: 20px;
            text-shadow:
                -1px -1px 0 black,
                 1px -1px 0 black,
                -1px 1px 0 black,
                 1px 1px 0 black;
        }

        p {
            font-size: 1rem;
            line-height: 1.5;
            margin-bottom: 30px;
            text-shadow: 1px 1px 2px black;
        }

        .btn-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }

        .btn {
            background-color: red;
            border: none;
            border-radius: 10px;
            color: white;
            padding: 12px 25px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s;
            text-decoration: none;
            flex: 1 1 45%;
            text-align: center;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.3);
        }

        .btn:hover {
            background-color: green;
        }

        /* 📱 Ajustes para pantallas pequeñas (celulares) */
        @media (max-width: 600px) {
            .container {
                padding: 30px 15px;
            }

            h1 {
                font-size: 1.8rem;
            }

            p {
                font-size: 0.95rem;
            }

            .btn {
                flex: 1 1 100%;
                padding: 14px;
                font-size: 1rem;
            }
        }

        /* 💻 Ajustes para pantallas grandes */
        @media (min-width: 1024px) {
            h1 {
                font-size: 2.5rem;
            }
            .btn {
                max-width: 220px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>¡Bienvenid@<%= (nombre != null) ? ", " + nombre : "" %>!</h1>
        <p>
            Nos alegra tenerte aquí. Si deseas registrar un nuevo usuario, haz clic en el botón <strong>Registrar</strong> que corresponda.<br>
            En caso contrario, puedes hacer clic en <strong>Continuar</strong> para acceder a nuestro sistema.
        </p>

        <div class="btn-container">
            <a href="registro_usuarios.jsp" class="btn">Registrar Usuario</a>
            <a href="registroLider.jsp" class="btn">Registrar Líder</a>
            <a href="registroPuesto.jsp" class="btn">Registrar Puesto</a>
            <a href="Registro.jsp" class="btn">Continuar</a>
        </div>
    </div>
</body>
</html>

