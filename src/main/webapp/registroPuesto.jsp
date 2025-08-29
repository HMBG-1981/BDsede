<%-- 
    Document   : registroPuesto
    Created on : 26/08/2025, 2:42:48 p. m.
    Author     : jedab
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Registro de Puesto</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: url(img/Fondo.png);
                margin: 0;
                padding: 10px;
            }

            form {
                background: linear-gradient(135deg, #0d6efd, #d9534f);
                max-width: 600px;
                margin: auto;
                margin-top: -1%;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                border-top: 6px solid #0d6efd;
            }      
           

            h2 {
                text-align: center;
                color: red;
                margin-top: -2px;
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
            input, select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 8px;
                box-sizing: border-box;
            }

            input[type="text"],
            input[type="password"]{
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 8px;
                box-sizing: border-box;
            }

            button {
                padding: 12px;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.3s;
                width: 100%;
            }
            .btn-registrar{
                color: white;
                background-color: green;
            }
            .btn-registrar:hover {
                background-color: blue;
            }

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

            input[type="submit"],
            .btn-buscar {
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

            input[type="submit"]:hover,
            .btn-buscar:hover {
                background-color: green;
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

            footer {
                font-size: 80%;
                color: red;
                bottom: 10px;
                left: 10px;
                text-align: left;
                text-shadow: 1px 1px 0 black;
            }

            .copyright-logo {
                width: 20px;
                vertical-align: middle;
            }
        </style>
    </head>
    <body>
        <h2>Registro Puesto de Votacion</h2>
        <form action="RegistroPuestoServlet" method="post" onsubmit="return validarContrasena();">
            <div class="form-row">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>
            

            <div class="botonera">
                <div class="form-group">
                    <button type="submit" class="btn-buscar">Registrar</button>
                </div>
                <div class="form-group"> 
                    <button type="button" class="btn-buscar" onclick="window.location.href = 'bienvenida.jsp'">Regresar</button>
                </div>
            </div>
        </form>
        <form action="CargarPuestoServlet" method="post" enctype="multipart/form-data">
            <h2>Cargar Datos desde Excel</h2>

            <div class="form-row">
                <div class="form-group">
                    <label for="archivoExcel">Selecciona archivo Excel (.xlsx):</label>
                    <input type="file" id="archivoExcel" name="archivoExcel" accept=".xlsx" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group" style="flex: none; width: 30%;">
                    <button type="submit" class="btn-registrar">Cargar Excel</button>
                </div>
            </div>
        </form>
        <footer>
            <img src="img/pngegg.png" alt="Copyright" class="copyright-logo">
            <b>2024. Todos los derechos reservados. BDsedo V1.0.0</b>
        </footer>

        <% 
            String mensaje = request.getParameter("mensaje");
            if (mensaje != null) {
        %>
        <p class="mensaje"><%= mensaje %></p>
        <% } %>


    </body>
</html>
