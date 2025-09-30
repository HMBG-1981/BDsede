<%--
    Document   : registro_usuarios
    Created on : 29/05/2025, 12:21:04 p. m.
    Author     : Administrador
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
    <style>
        /* --- ESTILOS GENERALES --- */
        body {
            font-family: 'Segoe UI', sans-serif;
            background: url('img/Fondo.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 10px;
        }

        h2 {
            text-align: center;
            color: red;
            margin-top: 5%;
            margin-bottom: 30px;
            font-size: 2.2em;
            text-shadow:
                -1px -1px 0 black,
                1px -1px 0 black,
                -1px 1px 0 black,
                1px 1px 0 black;
        }

        /* --- FORMULARIO --- */
        form {
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            max-width: 600px;
            width: 90%;
            margin: 20px auto;
            padding: 30px;
            border-radius: 15px;
            border-top: 6px solid #0d6efd;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 15px;
        }

        .form-group {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            color: #ffffff;
            margin-bottom: 6px;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-sizing: border-box;
            outline: none;
            font-size: 1em;
        }

        input:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 5px rgba(13, 110, 253, 0.5);
        }

        /* --- BOTONES --- */
        .botonera {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 25px;
            justify-content: center;
        }

        .botonera .form-group {
            flex: none;
            width: 45%;
        }

        button {
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            background-color: red;
            color: white;
            transition: 0.3s ease;
        }

        button:hover {
            background-color: green;
            transform: scale(1.02);
        }

        /* --- RESPONSIVE --- */
        @media (max-width: 700px) {
            form {
                padding: 20px;
            }
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

        /* --- MENSAJE Y PIE --- */
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

        footer {
            margin-top: 7%;
            font-size: 0.9em;
            color: red;
            text-align: center;
            text-shadow: 1px 1px 0 black;
        }

        .copyright-logo {
            width: 20px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <h2>Registro de Usuarios</h2>

    <form action="UsuariosServlet" method="post" onsubmit="return validarContrasena();">
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
            <div class="form-group">
                <label for="contrasena">Contraseña:</label>
                <input type="password" id="contrasena" name="contrasena" required>
            </div>
        </div>

        <div class="botonera">
            <div class="form-group">
                <button type="submit">Registrar</button>
            </div>
            <div class="form-group"> 
                <button type="button" onclick="window.location.href = 'bienvenida.jsp'">Regresar</button>
            </div>
        </div>
    </form>

    <% 
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null) {
    %>
    <p class="mensaje"><%= mensaje %></p>
    <% } %>

    <footer>
        <img src="img/pngegg.png" alt="Copyright" class="copyright-logo">
        <b>2024. Todos los derechos reservados. BDsedo V1.0.0</b>
    </footer>

    <script>
        function validarContrasena() {
            const contrasena = document.getElementById("contrasena").value;
            const mensaje = "La contraseña debe tener al menos:\n\n" +
                "- 8 caracteres\n" +
                "- Una letra mayúscula\n" +
                "- Un número\n" +
                "- Un carácter especial (!@#$%^&* etc.)";

            const tieneLongitud = contrasena.length >= 8;
            const tieneMayuscula = /[A-Z]/.test(contrasena);
            const tieneNumero = /\d/.test(contrasena);
            const tieneEspecial = /[!@#$%^&*(),.?\":{}|<>]/.test(contrasena);

            if (!(tieneLongitud && tieneMayuscula && tieneNumero && tieneEspecial)) {
                alert(mensaje);
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
