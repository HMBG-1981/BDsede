<%-- 
    Document   : editar_votante
    Created on : 29/05/2025, 9:46:26 a. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="conection.conexionbd" %> <!-- ✅ Importar clase de conexión -->
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Editar Votante</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- (🎨 Tus estilos se mantienen exactamente iguales) -->
        <style>
            /* Estilos base */
            body {
                font-family: 'Segoe UI', sans-serif;
                background: url('img/Fondo.png') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding: 15px;
            }
            h2 {
                text-align: center;
                color: red;
                margin-bottom: 25px;
                font-size: 2.3rem;
                text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black;
            }
            form {
                background: linear-gradient(135deg, #0d6efd, #d9534f);
                max-width: 850px;
                margin: 0 auto;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.25);
                border-top: 6px solid #0d6efd;
            }
            label {
                display: block;
                font-weight: bold;
                color: #fff;
                margin-bottom: 5px;
            }
            input, select {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ced4da;
                border-radius: 8px;
                margin-bottom: 12px;
                box-sizing: border-box;
                font-size: 16px;
            }
            .form-row {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
            }
            .form-group {
                flex: 1;
                min-width: 250px;
            }
            .botonera {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
                margin-top: 15px;
            }
            button {
                flex: 1 1 200px;
                padding: 12px;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                color: white;
                font-weight: bold;
                transition: transform 0.2s ease, background 0.3s ease;
            }
            button:hover {
                transform: scale(1.05);
            }
            .btn-buscar {
                background-color: #dc3545;
            }
            .btn-buscar:hover {
                background-color: #198754;
            }
            .btn-registrar {
                background-color: #ff0800;
            }
            .btn-registrar:hover {
                background-color: #198754;
            }
            .mensaje {
                font-size: 18px;
                font-weight: bold;
                text-align: center;
                color: #fff;
                margin-top: 15px;
                text-shadow: -1px -1px 0 black, 1px 1px 0 black;
            } /* 📱 Responsividad */
            @media (max-width: 768px) {
                form {
                    padding: 20px;
                }
                h2 {
                    font-size: 1.8rem;
                }
                .form-row {
                    flex-direction: column;
                    gap: 10px;
                }
                input, select {
                    font-size: 15px;
                }
                button {
                    flex: 1 1 100%;
                    font-size: 15px;
                }
            }
            @media (max-width: 480px) {
                h2 {
                    font-size: 1.5rem;
                }
                button {
                    padding: 10px;
                }
            }
            /* ... resto del CSS igual ... */
        </style>
    </head>
    <body>
        <h2>Editar Registro</h2>

        <!-- 🔍 Formulario para buscar -->
        <form method="get" action="editar_votante.jsp">
            <label for="cedula">Cédula:</label>
            <input type="text" id="cedula" name="cedula" 
                   value="<%= request.getParameter("cedula") != null ? request.getParameter("cedula") : "" %>" required>

            <div class="botonera">
                <button type="submit" class="btn-buscar">Buscar</button>
                <button type="button" class="btn-buscar" onclick="window.location.href = 'Registro.jsp'">Regresar</button>
            </div>
        </form>

        <% 
            // Mostrar mensajes de resultado
            String mensaje = request.getParameter("mensaje");
            if ("actualizado".equals(mensaje)) { 
        %>
        <p class="mensaje">✅ Registro actualizado correctamente.</p>
        <% } else if ("error".equals(mensaje)) { %>
        <p class="mensaje">❌ No se pudo actualizar el registro.</p>
        <% } else if ("eliminado".equals(mensaje)) { %>
        <p class="mensaje">🗑️ Registro eliminado correctamente.</p>
        <% } %>

        <%
            // Variables
            String cedula = request.getParameter("cedula");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            boolean encontrado = false;

            String nombres = "", direccion = "", telefono = "", puesto = "", mesa = "", ciudad = "", lider = "", observacion = "";

            // ✅ Solo buscar si hay cédula y no hay mensaje activo
            if (cedula != null && !cedula.isEmpty() && (mensaje == null || mensaje.isEmpty())) {
                try {
                    // ✅ Obtener conexión desde la clase conexionbd (Railway)
                    conn = conexionbd.getConnection();

                    String sql = "SELECT * FROM registro_votantes WHERE Cedula = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, cedula);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        encontrado = true;
                        nombres = rs.getString("Nombre");
                        direccion = rs.getString("Direccion");
                        telefono = rs.getString("Telefono");
                        puesto = rs.getString("Puesto");
                        mesa = rs.getString("Mesa");
                        ciudad = rs.getString("Ciudad");
                        lider = rs.getString("Lider");
                        observacion = rs.getString("Observacion");
                    }

                } catch (Exception e) {
                    out.println("<p class='mensaje'>⚠️ Error de conexión: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (conn != null && !conn.isClosed()) conn.close(); } catch (Exception e) {}
                }
            }

            if (cedula != null && encontrado) {
        %>

        <!-- ✏️ Formulario de edición -->
        <form method="post" action="EditarRegistroServlet">
            <input type="hidden" name="cedula" value="<%= cedula %>">

            <!-- Campos -->
            <div class="form-row">
                <div class="form-group">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" value="<%= nombres %>" required>
                </div>
                <div class="form-group">
                    <label>Dirección:</label>
                    <input type="text" name="direccion" value="<%= direccion %>">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Teléfono:</label>
                    <input type="text" name="telefono" value="<%= telefono %>">
                </div>
                <div class="form-group">
                    <label>Puesto:</label>
                    <input type="text" name="puesto" value="<%= puesto %>">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Mesa:</label>
                    <input type="text" name="mesa" value="<%= mesa %>">
                </div>
                <div class="form-group">
                    <label>Ciudad:</label>
                    <input type="text" name="ciudad" value="<%= ciudad %>" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Líder:</label>
                    <input type="text" name="lider" value="<%= lider %>" required>
                </div>
                <div class="form-group">
                    <label>Observación:</label>
                    <input type="text" name="observacion" value="<%= observacion %>">
                </div>
            </div>

            <div class="botonera">
                <button type="submit" class="btn-registrar">Guardar Cambios</button>
                <button type="submit" formaction="EliminarRegistroServlet" onclick="return confirm('¿Estás seguro de eliminar este registro?');" class="btn-registrar" style="background-color:#dc3545;">Eliminar</button>
            </div>
        </form>

        <% } else if (cedula != null && !encontrado) { %>
        <p class="mensaje">❌ No se encontró un registro con esa cédula.</p>
        <% } %>
    </body>
</html>
