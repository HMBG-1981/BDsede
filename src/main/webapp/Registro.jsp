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
            text-shadow: -1px -1px 0 black,
                         1px -1px 0 black,
                        -1px  1px 0 black,
                         1px  1px 0 black;
        }

        .mensaje {
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
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s;
            width: 100%;
        }

        .btn-registrar {
            background-color: blue;
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
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .botonera .form-group {
            flex: 1;
        }

        @media (max-width: 700px) {
            .form-row {
                flex-direction: column;
            }
            .botonera {
                flex-direction: column;
            }
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

        <div class="form-row">
            <div class="form-group">
                <label for="direccion">Dirección</label>
                <input type="text" id="direccion" name="direccion" required>
            </div>
            <div class="form-group">
                <label for="telefono">Teléfono:</label>
                <input type="tel" id="telefono" name="telefono" 
                       required pattern="[0-9]{7,10}" 
                       title="Ingrese un número válido">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="puesto">Puesto</label>
                <select id="puesto" name="puesto" required>
                    <option value="">Seleccione un puesto</option>
                    <%
                        Connection connP = null;
                        PreparedStatement psP = null;
                        ResultSet rsP = null;
                        try {
                            connP = conexionbd.getConnection();
                            String sqlP = "SELECT nombre FROM puestoVotacion ORDER BY nombre ASC";
                            psP = connP.prepareStatement(sqlP);
                            rsP = psP.executeQuery();
                            while (rsP.next()) {
                    %>
                                <option value="<%=rsP.getString("nombre")%>"><%=rsP.getString("nombre")%></option>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<option>Error cargando puestos</option>");
                        } finally {
                            if (rsP != null) try { rsP.close(); } catch (Exception ex) {}
                            if (psP != null) try { psP.close(); } catch (Exception ex) {}
                            if (connP != null) try { connP.close(); } catch (Exception ex) {}
                        }
                    %>
                </select>
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
                <label for="lider">Líder</label>
                <select id="lider" name="lider" required>
                    <option value="">Seleccione un líder</option>
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            conn = conexionbd.getConnection();
                            // Consulta desde la tabla "lideres"
                            String sql = "SELECT nombre FROM lideres ORDER BY nombre ASC";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                    %>
                                <option value="<%=rs.getString("nombre")%>"><%=rs.getString("nombre")%></option>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<option>Error cargando líderes</option>");
                        } finally {
                            if (rs != null) try { rs.close(); } catch (Exception ex) {}
                            if (ps != null) try { ps.close(); } catch (Exception ex) {}
                            if (conn != null) try { conn.close(); } catch (Exception ex) {}
                        }
                    %>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="observacion">Observación</label>
                <input type="text" id="observacion" name="observacion" required>
            </div>
        </div>

        <!-- Botones alineados en una línea -->
        <div class="botonera">
            <div class="form-group">
                <button type="submit" class="btn-registrar">Enviar</button>
            </div>
            <div class="form-group">
                <button type="button" class="btn-buscar" 
                        onclick="window.location.href = 'buscar_lider.jsp'">
                    Buscar
                </button>
            </div>
            <div class="form-group">
                <button type="button" class="btn-buscar" 
                        onclick="window.location.href = 'editar_votante.jsp'">
                    Editar
                </button>
            </div>
            <div class="form-group">
                <button type="button" class="btn-buscar" 
                        onclick="window.location.href = 'cerrar_sesion.jsp'">
                    Cerrar Sesión
                </button>
            </div>
        </div>
    </form>

    <!-- Formulario para cargar Excel -->
    <form action="CargarExcelServlet" method="post" enctype="multipart/form-data">
        <h2>Cargar Datos desde Excel</h2>

        <div class="form-row">
            <div class="form-group">
                <label for="archivoExcel">Selecciona archivo Excel (.xlsx):</label>
                <input type="file" id="archivoExcel" name="archivoExcel" 
                       accept=".xlsx" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group" style="flex: none; width: 30%;">
                <button type="submit" class="btn-registrar">Cargar Excel</button>
            </div>
        </div>
    </form>

    <!-- Pie de página -->
    <footer>
        <img src="img/pngegg.png" alt="Copyright" 
             class="copyright-logo">
        <b>2024. Todos los derechos reservados. BDsedo V1.0.0</b>
    </footer>

</body>
</html>
