<%-- 
    Document   : Registro
    Created on : 18/05/2025, 1:29:53 p. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> <!-- Define el tipo de contenido como HTML y la codificación como UTF-8 -->
<!DOCTYPE html>
<html lang="es"> <!-- Indica que el idioma principal de la página es español -->
    <head>
        <meta charset="UTF-8"> <!-- Codificación de caracteres -->
        <title>Formulario de Registro</title> <!-- Título que aparece en la pestaña del navegador -->

        <!-- Estilos CSS para el diseño visual -->
        <style>
            body {
                font-family: 'Segoe UI', sans-serif; /* Fuente principal */
                background: url(img/bandera.jpg);
                margin: 0;
                padding: 10px;
            }

            form {
                background: linear-gradient(135deg, #0d6efd, #d9534f);
                max-width: 800px; /* Ancho máximo */
                margin: auto; /* Centrado horizontal */
                padding: 30px;
                border-radius: 15px; /* Bordes redondeados */
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1); /* Sombra suave */
                border-top: 6px solid #0d6efd; /* Borde superior azul */
            }

            h2 {
                text-align: center;
                color: red; /* Rojo */
                margin-bottom: 30px;
                font-size: 35px;
                text-shadow:
                    -1px -1px 0 black,
                    1px -1px 0 black,
                    -1px 1px 0 black,
                    1px 1px 0 black;    /* crea el efecto de delineado */
            }

            .form-row {
                display: flex;
                gap: 30px;
                margin-bottom: 9px;
                flex-wrap: wrap; /* Permite que se adapten en pantallas pequeñas */
            }

            .form-group {
                flex: 1; /* Cada grupo ocupa el mismo espacio */
            }

            label {
                display: block;
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

            button {
                margin-left: 130px;
                width: 100%;
                padding: 12px;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .btn-registrar {
                background-color: #ff0800;
                color: white;
            }

            .btn-registrar:hover {
                background-color: #e00700;
            }

            .btn-buscar {
                background-color: #0d6efd;
                color: white;
            }

            .btn-buscar:hover {
                background-color: #0056d2;
            }

            @media (max-width: 700px) {
                .form-row {
                    flex-direction: column; /* Cambia el diseño a columna en pantallas pequeñas */
                }
            }

            footer {
                font-size: 80%;
                color: red;
                bottom: 10px;
                left: 10px;
                text-align: left;
                text-shadow: 1px 1px 0 black; /* Sombra para mejor visibilidad */
            }

            .copyright-logo {
                width: 20px;
                vertical-align: middle;
            }
        </style>
    </head>
    <body>

        <!-- Formulario principal de registro -->
        <form action="RegistroServlet" method="post"> <!-- Envia datos al servlet "RegistroServlet" usando POST -->

            <h2>Formulario de Registro</h2>

            <!-- Fila con campos de nombre y cédula -->
            <div class="form-row">
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>

                <div class="form-group">
                    <label for="cedula">Cédula</label>
                    <input type="text" id="cedula" name="cedula" required>
                </div>
            </div>

            <!-- Fila con dirección y teléfono -->
            <div class="form-row">
                <div class="form-group">
                    <label for="direccion">Dirección</label>
                    <input type="text" id="direccion" name="direccion" required>
                </div>

                <div class="form-group">
                    <label for="telefono">Teléfono:</label>
                    <input type="tel" id="telefono" name="telefono" required pattern="[0-9]{7,10}" title="Ingrese un número válido">
                </div>
            </div>

            <!-- Fila con puesto y mesa (opciones generadas dinámicamente con JSP) -->
            <div class="form-row">
                <div class="form-group">
                    <label for="puesto">Puesto</label>
                    <input type="text" id="puesto" name="puesto" required>
                </div>

                <div class="form-group">
                    <label for="mesa">Mesa:</label>
                    <select id="mesa" name="mesa" required>
                        <option value="">Seleccione una mesa</option>
                        <% for (int i = 1; i <= 50; i++) { %>
                        <option value="<%=i%>"><%=i%></option> <!-- Opciones de 1 a 50 -->
                        <% } %>
                    </select>
                </div>
            </div>

            <!-- Fila con ciudad y líder -->
            <div class="form-row">
                <div class="form-group">
                    <label for="ciudad">Ciudad</label>
                    <input type="text" id="ciudad" name="ciudad" required>
                </div>

                <div class="form-group">
                    <label for="lider">Líder</label>
                    <input type="text" id="lider" name="lider" required>
                </div>
            </div>

            <!-- Campo de observaciones -->
            <div class="form-row">
                <div class="form-group">
                    <label for="observacion">Observación</label>
                    <input type="text" id="observacion" name="observacion" required>
                </div>
            </div>

            <!-- Botones de registrar y buscar -->
            <div class="form-row" style="justify-content: flex-start; margin-top: 20px;">
                <div class="form-group" style="flex: none; width: 30%;">
                    <button type="submit" class="btn-registrar">Registrar</button>
                </div>
                <div class="form-group" style="flex: none; width: 30%; margin-left: 20px;">
                    <button type="button" class="btn-buscar" onclick="window.location.href = 'buscar_lider.jsp'">
                        Buscar
                    </button>
                </div>
            </div>
        </form>

        <!-- Segundo formulario para cargar archivo Excel -->
        <form action="CargarExcelServlet" method="post" enctype="multipart/form-data">
            <h2>Cargar Datos desde Excel</h2>

            <!-- Campo para seleccionar el archivo -->
            <div class="form-row">
                <div class="form-group">
                    <label for="archivoExcel">Selecciona archivo Excel (.xlsx):</label>
                    <input type="file" id="archivoExcel" name="archivoExcel" accept=".xlsx" required>
                </div>
            </div>

            <!-- Botón para cargar el archivo -->
            <div class="form-row">
                <div class="form-group" style="flex: none; width: 30%;">
                    <button type="submit" class="btn-registrar">Cargar Excel</button>
                </div>
            </div>
        </form>

        <!-- Pie de página con logotipo y derechos -->
        <footer>
            <img src="img/pngegg.png" alt="Copyright" class="copyright-logo">
            <b>2024. Todos los derechos reservados. BDsedo V1.0.0</b>
        </footer> 

    </body>
</html>
