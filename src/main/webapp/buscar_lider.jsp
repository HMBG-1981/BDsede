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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscar Líder</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('img/Fondo.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        h2 {
            text-align: center;
            color: red;
            font-size: 2.2rem;
            text-shadow:
                -1px -1px 0 black,
                 1px -1px 0 black,
                -1px 1px 0 black,
                 1px 1px 0 black;
            margin-bottom: 20px;
        }

        form {
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            width: 90%;
            max-width: 500px;
            margin: auto;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            color: #fff;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #fff;
            text-shadow: 1px 1px 2px black;
        }

        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 1rem;
        }

        .btn-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
            margin-top: 10px;
        }

        button {
            flex: 1 1 45%;
            background-color: red;
            color: white;
            padding: 12px 18px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 1rem;
            text-shadow: 1px 1px 2px black;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.3);
        }

        button:hover {
            background-color: green;
        }

        .exportar-btn {
            background-color: #28a745;
        }

        .exportar-btn:hover {
            background-color: #218838;
        }

        /* 📱 Ajustes para móviles */
        @media (max-width: 600px) {
            form {
                padding: 20px;
            }

            h2 {
                font-size: 1.8rem;
            }

            select {
                font-size: 0.95rem;
                padding: 10px;
            }

            button {
                flex: 1 1 100%;
                font-size: 1rem;
                padding: 14px;
            }
        }

        /* 💻 Ajustes para pantallas grandes */
        @media (min-width: 1024px) {
            h2 {
                font-size: 2.5rem;
            }
            form {
                max-width: 600px;
            }
        }
    </style>
</head>
<body>
    <div>
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

            <!-- Campo mesa -->
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
                <button type="button" onclick="window.location.href='modulo_puestos.jsp'">Otras Consultas</button>
                <button type="button" onclick="window.location.href='Registro.jsp'">Regresar</button>
            </div>

        </form>
    </div>
</body>
</html>
