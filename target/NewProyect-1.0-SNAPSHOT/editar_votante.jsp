<%-- 
    Document   : editar_votante
    Created on : 29/05/2025, 9:46:26 a. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Editar Votante</title>
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
                font-size: 40px;
                text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px 1px 0 black;
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
                width: 40%;
                margin-top: 3%;
                margin-left: 5%;
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
                background-color: green;
            }

            .btn-buscar {
                background-color: red;
                color: white;
            }

            .btn-buscar:hover {
                background-color: green;
            }

            .botonera {
                margin-left: 20%;
                display: flex;
                justify-content: space-between;
                gap: 1px;
                margin-top: 20px;
            }

            .botonera .form-group {
                flex: 1;
            }

            @media (max-width: 700px) {
                .form-row {
                    flex-direction: column;
                }
            }

            .mensaje {
                font-size: 18px;
                font-weight: bold;
                margin-top: 20px;
                text-align: center;
                color: white;
                text-shadow:
                    -1px -1px 0 black,
                    1px -1px 0 black,
                    -1px  1px 0 black,
                    1px  1px 0 black;
            }

            .mensaje.error {
                padding: 10px;
                border-radius: 8px;
            }

            .mensaje.exito {
                padding: 10px;
                border-radius: 8px;
            }
        </style>
    </head>
    <body>
        <h2>Editar Registro</h2>

        <form method="get" action="editar_votante.jsp">
            <label>Cédula:</label>
            <input type="text" name="cedula" value="<%= request.getParameter("cedula") != null ? request.getParameter("cedula") : "" %>" required>
            <div class="botonera">
                <div class="form-group">
                    <button type="submit" class="btn-buscar">Buscar</button>
                </div>
                <div class="form-group"> 
                    <button type="button" class="btn-buscar" onclick="window.location.href = 'Registro.jsp'">Regresar</button>
                </div>
            </div>
        </form>

        <%
            String mensaje = request.getParameter("mensaje");
            if ("actualizado".equals(mensaje)) {
        %>
        <p class="mensaje exito">✅ Registro actualizado correctamente.</p>
        <%
            } else if ("error".equals(mensaje)) {
        %>
        <p class="mensaje error">❌ No se pudo actualizar el registro.</p>
        <%
            } else if ("eliminado".equals(mensaje)) {
        %>
        <p class="mensaje exito">🗑️ Registro eliminado correctamente.</p>
        <%
            }

            String cedula = request.getParameter("cedula");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            boolean encontrado = false;

            String nombres = "", direccion = "", telefono = "", puesto = "", mesa = "", ciudad = "", lider = "", observacion = "";

            if (cedula != null && !cedula.isEmpty() && (mensaje == null || mensaje.isEmpty())) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BDsede", "root", "1981bcG@");

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
                    out.println("<p class='mensaje error'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (conn != null) conn.close(); } catch (Exception e) {}
                }
            }

            if (cedula != null && encontrado) {
        %>

        <form method="post" action="EditarRegistroServlet">
            <input type="hidden" name="cedula" value="<%= cedula %>">
            <div class="form-row">
                <div class="form-group">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" value="<%= nombres %>" required>
                </div>
                <div class="form-group">
                    <label>Dirección:</label>
                    <input type="text" name="direccion" value="<%= direccion %>" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Teléfono:</label>
                    <input type="text" name="telefono" value="<%= telefono %>" required>
                </div>
                <div class="form-group">
                    <label>Puesto:</label>
                    <input type="text" name="puesto" value="<%= puesto %>" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Mesa:</label>
                    <input type="text" name="mesa" value="<%= mesa %>" required>
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

            <br>
            <button type="submit" class="btn-registrar">Guardar Cambios</button>
            <button type="submit" formaction="EliminarRegistroServlet" onclick="return confirm('¿Estás seguro de que deseas eliminar este registro?');" class="btn-registrar" style="background-color: red;">Eliminar</button>
        </form>


        <%
            } else if (cedula != null && !encontrado) {
        %>
        <p class="mensaje error">❌ No se encontró un registro con esa cédula.</p>
        <%
            }
        %>
    </body>
</html>
