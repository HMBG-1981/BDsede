<%-- 
    Document   : registroPuesto
    Created on : 26/08/2025, 2:42:48 p. m.
    Author     : jedab
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="es">
<head>
    <title>Registro de Puesto</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- clave para móviles -->
    <style>
        /* ==== RESETEO Y ESTILOS BASE ==== */
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: url('img/Fondo.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 10px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }

        h2 {
            text-align: center;
            color: red;
            margin: 10px 0 25px;
            font-size: 2rem;
            text-shadow: -1px -1px 0 black,
                         1px -1px 0 black,
                         -1px 1px 0 black,
                         1px 1px 0 black;
        }

        form {
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            max-width: 600px;
            width: 95%;
            margin: 20px auto;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            border-top: 6px solid #0d6efd;
        }

        label {
            font-weight: bold;
            color: #ffffff;
            margin-bottom: 6px;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 16px;
        }

        /* ==== BOTONES ==== */
        button {
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-buscar {
            background-color: red;
            color: white;
        }

        .btn-buscar:hover {
            background-color: green;
        }

        .btn-registrar {
            background-color: #198754;
            color: white;
        }

        .btn-registrar:hover {
            background-color: #0d6efd;
        }

        /* ==== ESTRUCTURA ==== */
        .form-row {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .botonera {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            margin-top: 10px;
        }

        p.mensaje {
            text-align: center;
            font-weight: bold;
            color: yellow;
            text-shadow: -1px -1px 0 black,
                         1px -1px 0 black,
                         -1px 1px 0 black,
                         1px 1px 0 black;
            margin-top: 15px;
        }

        footer {
            text-align: center;
            color: red;
            font-size: 0.9rem;
            margin-top: auto;
            text-shadow: 1px 1px 0 black;
        }

        footer img {
            width: 20px;
            vertical-align: middle;
        }

        /* ==== RESPONSIVE ==== */
        @media (max-width: 768px) {
            h2 {
                font-size: 1.8rem;
            }

            form {
                padding: 20px;
            }

            .form-row {
                flex-direction: column;
            }

            .botonera {
                flex-direction: column;
            }

            button {
                font-size: 15px;
            }
        }

        @media (max-width: 480px) {
            h2 {
                font-size: 1.6rem;
            }
            input, select {
                font-size: 14px;
                padding: 10px;
            }
            button {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>

<body>
    <h2>Registro Puesto de Votación</h2>

    <!-- FORMULARIO PRINCIPAL -->
    <form action="RegistroPuestoServlet" method="post">
        <div class="form-row">
            <div class="form-group">
                <label for="nombre">Nombre del Puesto:</label>
                <input type="text" id="nombre" name="nombre" required>
            </div>
        </div>

        <div class="botonera">
            <button type="submit" class="btn-buscar">Registrar</button>
            <button type="button" class="btn-buscar" onclick="window.location.href='bienvenida.jsp'">Regresar</button>
        </div>
    </form>

    <!-- FORMULARIO DE CARGA EXCEL -->
    <form action="CargarPuestoServlet" method="post" enctype="multipart/form-data">
        <h2>Cargar Datos desde Excel</h2>
        <div class="form-row">
            <div class="form-group">
                <label for="archivoExcel">Selecciona archivo Excel (.xlsx):</label>
                <input type="file" id="archivoExcel" name="archivoExcel" accept=".xlsx" required>
            </div>
        </div>

        <div class="form-row">
            <button type="submit" class="btn-registrar">Cargar Excel</button>
        </div>
    </form>

    <% 
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null) {
    %>
        <p class="mensaje"><%= mensaje %></p>
    <% } %>

    <footer>
        <img src="img/pngegg.png" alt="Copyright">
        <b>2024. Todos los derechos reservados. BDsedo V1.0.0</b>
    </footer>
</body>
</html>
