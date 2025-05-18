<%-- 
    Document   : Registro
    Created on : 18/05/2025, 1:29:53 p. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Formulario de Registro</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #0d6efd, #d9534f); /* Azul a rojo */
                margin: 0;
                padding: 30px;
            }

            form {
                background: #ffffff;
                max-width: 800px;
                margin: auto;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                border-top: 6px solid #0d6efd;
            }

            h2 {
                text-align: center;
                color: #ff0800;
                margin-bottom: 30px;
            }

            .form-row {
                display: flex;
                gap: 30px;
                margin-bottom: 9px;
                flex-wrap: wrap;
            }

            .form-group {
                flex: 1;
            }

            label {
                display: block;
                font-weight: bold;
                color: #0d6efd;
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
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>

        <form action="RegistroServlet" method="post">

            <h2>Formulario de Registro</h2>

            <div class="form-row">
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>

                <div class="form-group">
                    <label for="cedula">Cedula</label>
                    <input type="text" id="cedula" name="cedula" required>
                </div>
            </div>

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
                        <option value="<%=i%>"><%=i%></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="ciudad">Ciudad</label>
                    <input type="text" id="ciudad" name="ciudad" required>
                </div>
                <div class="form-group">
                    <label for="lider">Lider</label>
                    <input type="text" id="lider" name="lider" required>
                </div>

            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="observacion">Observacion</label>
                    <input type="text" id="observacion" name="observacion" required>
                </div>

            </div>

            <!-- Botones en la misma fila -->
            <div class="form-row" style="justify-content: flex-start; margin-top: 20px;">
                <div class="form-group" style="flex: none; width: 30%;">
                    <button type="submit" class="btn-registrar">Registrarse</button>
                </div>
                <div class="form-group" style="flex: none; width: 30%; margin-left: 20px;">
                    <button type="button" class="btn-buscar" onclick="window.location.href = 'buscar_lider.jsp'">
                        Buscar
                    </button>
                </div>
            </div>
        </form>
        <form action="CargarExcelServlet" method="post" enctype="multipart/form-data">
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

    </body>
</html>