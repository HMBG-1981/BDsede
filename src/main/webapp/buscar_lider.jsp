<%-- 
    Document   : buscar_lider
    Created on : 18/05/2025, 4:24:39 p. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="conection.conexionbd" %> <%-- ✅ Importar clase de conexión personalizada --%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Buscar Líder</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url(img/Fondo.png);
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: red;
            font-size: 35px;
            text-shadow:
                -1px -1px 0 black,
                1px -1px 0 black,
                -1px 1px 0 black,
                1px 1px 0 black;
        }

        form {
            width: 90%;
            max-width: 500px;
            margin: 30px auto;
            padding: 20px;
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: red;
            text-shadow:
                -1px -1px 0 black,
                1px -1px 0 black,
                -1px 1px 0 black,
                1px 1px 0 black;
        }

        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #dcdde1;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .btn-container {
            display: flex;
            justify-content: space-between;
        }

        button {
            background-color: red;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: green;
        }

        .exportar-btn {
            background-color: #28a745;
        }

        .exportar-btn:hover {
            background-color: green;
        }
    </style>
</head>
<body>
    <h2>FILTRO GENERAL DE INFORMACIÓN</h2>

    <form action="buscarVotante" method="post">

        <!-- Campo líder -->
        <label for="lider">Líder:</label>
        <select name="lider" id="lider">
            <option value="">-- Seleccione un líder --</option>
            <%
                try (Connection con = conexionbd.getConnection();
                     Statement stmt = con.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT DISTINCT lider FROM registro_votantes ORDER BY lider")) {

                    while (rs.next()) {
                        String valor = rs.getString("lider");
            %>
            <option value="<%= valor %>"><%= valor %></option>
            <%
                    }
                } catch (Exception e) {
                    out.println("<option>Vacio...</option>");
                    e.printStackTrace();
                }
            %>
        </select>

        <!-- Campo puesto -->
        <label for="puesto">Puesto:</label>
        <select name="puesto" id="puesto">
            <option value="">-- Seleccione un puesto --</option>
            <%
                try (Connection con = conexionbd.getConnection();
                     Statement stmt = con.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT DISTINCT puesto FROM registro_votantes ORDER BY puesto")) {

                    while (rs.next()) {
                        String valor = rs.getString("puesto");
            %>
            <option value="<%= valor %>"><%= valor %></option>
            <%
                    }
                } catch (Exception e) {
                    out.println("<option>Vacio...</option>");
                    e.printStackTrace();
                }
            %>
        </select>

        <!-- Campo mesa con valores fijos del 1 al 50 -->
        <label for="mesa">Mesa:</label>
        <select name="mesa" id="mesa">
            <option value="">-- Seleccione una mesa --</option>
            <%
                for (int i = 1; i <= 50; i++) {
            %>
            <option value="<%= i %>"><%= i %></option>
            <%
                }
            %>
        </select>

        <!-- Botones -->
        <div class="btn-container">
            <button type="submit">Buscar</button>
            <button type="submit" formaction="exportarExcel" formmethod="get" class="exportar-btn">Exportar Excel</button>
            <button type="button" onclick="window.location.href = 'modulo_puestos.jsp'">Otras Consultas</button>
            <button type="button" class="btn-buscar" onclick="window.location.href = 'Registro.jsp'">Regresar</button>
        </div>

    </form>
</body>
</html>
