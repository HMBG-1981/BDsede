<%--
    Document   : registro_usuarios
    Created on : 29/05/2025, 12:21:04 p. m.
    Author     : Administrador
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- ✅ Para móviles -->
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
            font-size: 2em;
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
            width: 95%;
            margin: 20px auto;
            padding: 25px;
            border-radius: 15px;
            border-top: 5px solid #0d6efd;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
        }

        .form-group {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            color: #fff;
            margin-bottom: 6px;
        }

        input[type="text"],
        input[type="password"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1em;
            outline: none;
        }

        input:focus {
            border-color: #ffc107;
            box-shadow: 0 0 5px rgba(255, 193, 7, 0.6);
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
            font-weight: bold;
            letter-spacing: 0.5px;
            transition: 0.3s ease;
        }

        button:hover {
            background-color: green;
            transform: scale(1.03);
        }

        /* --- RESPONSIVE --- */
        @media (max-width: 768px) {
            h2 {
                font-size: 1.7em;
            }

            form {
                padding: 20px;
            }

            .form-row {
                flex-direction: column;
                gap: 10px;
            }

            .botonera {
                flex-direction: column;
            }

            .botonera .form-group {
                width: 100%;
            }

            input, select {
                font-size: 16px; /* ✅ Mejor para dedos en móviles */
            }
        }

        /* --- MENSAJE --- */
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

        /* --- PIE DE PÁGINA --- */
        footer {
            margin-top: 8%;
            font-size: 0.9em;
            color: red;
            text-align: center;
            text-shadow: 1px 1px 0 black;
        }

        .copyright-logo {
            width: 22px;
            vertical-align: middle;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <h2>Registro de Usuarios</h2>

    <form action="UsuariosServlet" method="post" onsubmit="return validarContrasena();">
        <div class="form-row">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" placeholder="Ej. Juan Pérez" required>
            </div>
            <div class="form-group">
                <label for="direccion">Dirección:</label>
                <input type="text" id="direccion" name="direccion" placeholder="Ej. Calle 10 # 5-20" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="cedula">Cédula:</label>
                <input type="number" id="cedula" name="cedula" placeholder="Ingrese su número" required>
            </div>
            <div class="form-group">
                <label for="telefono">Teléfono:</label>
                <input type="text" id="telefono" name="telefono" placeholder="Ej. 3001234567" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group" style="flex: 1;">
                <label for="contrasena">Contraseña:</label>
                <input type="password" id="contrasena" name="contrasena" placeholder="Cree una contraseña segura" required>
            </div>
        </div>

        <div class="botonera">
            <div class="form-group">
                <button type="submit">Registrar</button>
            </div>
            <div class="form-group">
                <button type="button" onclick="window.location.href='bienvenida.jsp'">Regresar</button>
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
        <b>2025. Todos los derechos reservados. BDSEDE V1.1.0</b>
    </footer>

    <script>
        // ✅ Validación avanzada de contraseña
        function validarContrasena() {
            const contrasena = document.getElementById("contrasena").value;
            const mensaje = 
                "La contraseña debe tener al menos:\n\n" +
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

