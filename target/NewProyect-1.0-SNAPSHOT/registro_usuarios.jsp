<%-- 
    Document   : registro_usuarios
    Created on : 29/05/2025, 12:21:04 p. m.
    Author     : Administrador
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Registro de Usuario</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: url(img/bandera.jpg);
            margin: 0;
            padding: 10px;
        }

        form {
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            max-width: 800px;
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

        .form-row {
            display: flex;
            gap: 30px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            color: #ffffff;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-sizing: border-box;
        }

        /* Botonera para los botones en línea */
        .botonera {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            justify-content: center;
        }

        .botonera .form-group {
            flex: none;
            width: 45%;
        }

        /* Estilos para ambos botones */
        input[type="submit"],
        .btn-buscar {
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s;
            width: 100%;
            background-color: #d9534f; /* rojo */
            color: white;
        }

        input[type="submit"]:hover,
        .btn-buscar:hover {
            background-color: #a93030; /* rojo más oscuro */
        }

        @media (max-width: 700px) {
            .form-row {
                flex-direction: column;
            }
            .botonera {
                flex-direction: column;
            }
            .botonera .form-group {
                width: 100%;
            }
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
    <h2>Formulario de Registro</h2>
    <form action="UsuariosServlet" method="post">
        <div class="form-row">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" required>
            </div>
            <div class="form-group">
                <label for="direccion">Dirección:</label>
                <input type="text" id="direccion" name="direccion" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="cedula">Cédula:</label>
                <input type="text" id="cedula" name="cedula" required>
            </div>
            <div class="form-group">
                <label for="telefono">Teléfono:</label>
                <input type="text" id="telefono" name="telefono" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group" style="flex: 1;">
                <label for="contrasena">Contraseña:</label>
                <input type="password" id="contrasena" name="contrasena" required>
            </div>
        </div>

        <div class="botonera">
            <div class="form-group">
                <input type="submit" value="Registrar">
            </div>
            <div class="form-group"> 
                <button type="button" class="btn-buscar" onclick="window.location.href = 'Registro.jsp'">Regresar</button>
            </div>
        </div>
    </form>

    <% 
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null) {
    %>
    <p class="mensaje"><%= mensaje %></p>
    <% } %>
</body>
</html>
