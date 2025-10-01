<%-- 
    Document   : Registro
    Created on : 18/05/2025, 1:29:53 p. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="conection.conexionbd"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Formulario de Registro</title>

        <!-- 📱 Hace que el sitio se vea bien en móviles -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            /* ====== ESTILOS GENERALES ====== */
            body {
                font-family: 'Segoe UI', sans-serif;
                background: url('img/Fondo.png') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding: 15px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            h2 {
                text-align: center;
                color: red;
                font-size: 2rem;
                text-shadow: -1px -1px 0 black,
                    1px -1px 0 black,
                    -1px  1px 0 black,
                    1px  1px 0 black;
                margin-bottom: 20px;
            }

            /* ====== FORMULARIOS ====== */
            form {
                background: linear-gradient(135deg, #0d6efd, #d9534f);
                width: 95%;
                max-width: 600px;
                margin: 20px auto;
                padding: 25px;
                border-radius: 15px;
                border-top: 6px solid #0d6efd;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.25);
                box-sizing: border-box;
            }

            .form-row {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
                margin-bottom: 10px;
            }

            .form-group {
                flex: 1;
                min-width: 100px;
            }

            label {
                font-weight: bold;
                color: #fff;
                display: block;
                margin-bottom: 6px;
                font-size: 1rem;
            }

            input, select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 8px;
                font-size: 1rem;
                box-sizing: border-box;
            }

            input:focus, select:focus {
                border-color: #198754;
                box-shadow: 0 0 5px rgba(25, 135, 84, 0.5);
                outline: none;
            }

            /* ====== MENSAJES ====== */
            .mensaje {
                width: 95%;
                max-width: 600px;
                margin: 15px auto;
                padding: 12px;
                border-radius: 8px;
                font-weight: bold;
                text-align: center;
            }

            .mensaje.exito {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .mensaje.error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            /* ====== BOTONES ====== */
            button {
                padding: 12px;
                font-size: 1rem;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
                font-weight: bold;
            }

            .btn-registrar {
                background-color: blue;
                color: white;
            }

            .btn-registrar:hover {
                background-color: green;
                transform: scale(1.03);
            }

            .btn-buscar {
                background-color: red;
                color: white;
            }

            .btn-buscar:hover {
                background-color: green;
                transform: scale(1.03);
            }

            /* Contenedor de botones */
            .botonera {
                display: flex;
                justify-content: space-between;
                gap: 15px;
                margin-top: 20px;
                flex-wrap: wrap;
            }

            .botonera .form-group {
                flex: 1;
                min-width: 130px;
            }

            /* ====== PIE DE PÁGINA ====== */
            footer {
                font-size: 0.9rem;
                color: red;
                text-shadow: 1px 1px 0 black;
                text-align: center;
                margin-top: 20px;
            }

            .copyright-logo {
                width: 18px;
                vertical-align: middle;
            }

            /* ====== RESPONSIVIDAD ====== */
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

                label, input, select {
                    font-size: 0.95rem;
                }

                button {
                    font-size: 0.95rem;
                }
            }

            @media (max-width: 480px) {
                h2 {
                    font-size: 1.5rem;
                }

                form {
                    padding: 15px;
                }

                label {
                    font-size: 0.9rem;
                }

                footer {
                    font-size: 0.75rem;
                }
            }
        </style>
    </head>
    <body>

        <!-- Mostrar mensaje de éxito o error -->
        <%
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) {
                boolean esExito = mensaje.contains("✅") || mensaje.toLowerCase().contains("exitoso");
        %>
        <div class="mensaje <%= esExito ? "exito" : "error" %>">
            <%= mensaje %>
        </div>
        <%
            }
        %>

        <!-- Formulario de registro -->
        <form action="RegistroServlet" method="post">
            <h2>BD CONGRESO 2026</h2>

            <!-- Fila 1 -->
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

            <!-- Fila 2 -->
            <div class="form-row">
                <div class="form-group">
                    <label for="direccion">Dirección</label>
                    <input type="text" id="direccion" name="direccion" required>
                </div>
                <div class="form-group">
                    <label for="telefono">Teléfono</label>
                    <input type="tel" id="telefono" name="telefono" required pattern="[0-9]{7,10}" title="Ingrese un número válido">
                </div>
            </div>

            <!-- Fila 3 -->
            <div class="form-row">
                <div class="form-group">
                    <label for="puesto">Puesto</label>
                    <select id="puesto" name="puesto" required>
                        <option value="">Seleccione un puesto</option>
                        <%
                            try (Connection connP = conexionbd.getConnection();
                                 PreparedStatement psP = connP.prepareStatement("SELECT nombre FROM puestoVotacion ORDER BY nombre ASC");
                                 ResultSet rsP = psP.executeQuery()) {
                                while (rsP.next()) {
                        %>
                        <option value="<%= rsP.getString("nombre") %>"><%= rsP.getString("nombre") %></option>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<option>Error cargando puestos</option>");
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="mesa">Mesa</label>
                    <select id="mesa" name="mesa" required>
                        <option value="">Seleccione una mesa</option>
                        <% for (int i = 1; i <= 50; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <!-- Fila 4 -->
            <div class="form-row">
                <div class="form-group">
                    <label for="ciudad">Ciudad</label>
                    <input type="text" id="ciudad" name="ciudad" required>
                </div>
                <div class="form-group">
                    <label for="lider">Líder</label>
                    <select id="lider" name="lider" required>
                        <option value="">Seleccione un líder</option>
                        <%
                            try (Connection conn = conexionbd.getConnection();
                                 PreparedStatement ps = conn.prepareStatement("SELECT nombre FROM lideres ORDER BY nombre ASC");
                                 ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                        %>
                        <option value="<%= rs.getString("nombre") %>"><%= rs.getString("nombre") %></option>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<option>Error cargando líderes</option>");
                            }
                        %>
                    </select>
                </div>
            </div>

            <!-- Fila 5 -->
            <div class="form-row">
                <div class="form-group">
                    <label for="observacion">Observación</label>
                    <input type="text" id="observacion" name="observacion" required>
                </div>
            </div>

            <!-- Botonera -->
            <div class="botonera">
                <div class="form-group">
                    <button type="submit" class="btn-registrar">Enviar</button>
                </div>
                <div class="form-group">
                    <button type="button" class="btn-buscar" onclick="window.location.href = 'buscar_lider.jsp'">Buscar</button>
                </div>
                <div class="form-group">
                    <button type="button" class="btn-buscar" onclick="window.location.href = 'editar_votante.jsp'">Editar</button>
                </div>
                <div class="form-group">
                    <button type="button" class="btn-buscar" onclick="window.location.href = 'cerrar_sesion.jsp'">Cerrar Sesión</button>
                </div>
            </div>
        </form>

        <!-- Formulario Cargar Excel -->
        <form action="CargarExcelServlet" method="post" enctype="multipart/form-data">
            <h2>Cargar Datos desde Excel</h2>

            <div class="form-row">
                <div class="form-group">
                    <label for="archivoExcel">Selecciona archivo Excel (.xlsx):</label>
                    <input type="file" id="archivoExcel" name="archivoExcel" accept=".xlsx" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group" style="flex: none; width: 40%;">
                    <button type="submit" class="btn-registrar">Cargar Excel</button>
                </div>
            </div>
        </form>

        <!-- Footer -->
        <footer>
            <img src="img/pngegg.png" alt="Copyright" class="copyright-logo">
            <b>2024. Todos los derechos reservados. BDsede V1.0.0</b>
        </footer>

    </body>
</html>
