<%-- 
    Document   : modulo_puestos
    Created on : 11/06/2025, 9:22:51 a. m.
    Author     : Administrador
--%>

<%@ page import="java.util.*, java.sql.*, conection.conexionbd" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Módulo de Consulta de Puestos</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        /* 🎨 Estilos generales */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('img/Fondo.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 15px;
        }

        h2 {
            margin-top: 5%;
            text-align: center;
            color: red;
            font-size: 2.2rem;
            text-shadow:
                -1px -1px 0 black,
                1px -1px 0 black,
                -1px 1px 0 black,
                1px 1px 0 black;
        }

        form {
            width: 95%;
            max-width: 600px;
            margin: 30px auto;
            padding: 25px;
            background: linear-gradient(135deg, #0d6efd, #d9534f);
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.25);
            color: white;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: black;
            font-size: 1rem;
        }

        /* 📋 Contenedor del select personalizado */
        .custom-select {
            position: relative;
            width: 100%;
            margin-bottom: 20px;
        }

        .select-box {
            background-color: #fff;
            border: 1px solid #dcdde1;
            border-radius: 8px;
            padding: 12px;
            cursor: pointer;
            font-size: 16px;
            color: #333;
            text-align: left;
        }

        #checkboxes {
            display: none;
            border: 1px solid #dcdde1;
            border-radius: 8px;
            padding: 10px;
            background-color: #fff;
            position: absolute;
            width: 100%;
            max-height: 180px;
            overflow-y: auto;
            z-index: 100;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        #checkboxes label {
            color: #000;
            margin-bottom: 6px;
            display: block;
            font-weight: normal;
            font-size: 15px;
        }

        /* 🧭 Botones */
        .btn-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-container button {
            flex: 1 1 45%;
            min-width: 130px;
            background-color: #dc3545;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
            font-weight: bold;
        }

        .btn-container button:hover {
            background-color: #198754;
            transform: scale(1.05);
        }

        /* 🧾 Resultado */
        .resultado {
            width: 95%;
            max-width: 600px;
            margin: 20px auto;
            background: #fff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.25);
            color: #333;
            font-size: 16px;
        }

        /* 📱 Responsividad */
        @media (max-width: 768px) {
            h2 {
                font-size: 1.8rem;
                margin-top: 10%;
            }

            form {
                padding: 20px;
            }

            .btn-container button {
                flex: 1 1 100%;
                font-size: 15px;
            }

            .select-box {
                font-size: 15px;
                padding: 10px;
            }
        }

        @media (max-width: 480px) {
            h2 {
                font-size: 1.6rem;
            }

            .btn-container {
                gap: 8px;
            }

            .btn-container button {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>

<body>
    <h2>Módulo de Consulta de Puestos</h2>

    <form action="ConsultaPuestosServlet" method="post">
        <label>Selecciona uno o varios puestos:</label>

        <div class="custom-select">
            <div class="select-box" onclick="toggleCheckboxes()">Seleccionar puestos</div>
            <div id="checkboxes">
                <label>
                    <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)"> Seleccionar todos
                </label>

                <% 
                    try (Connection conn = conexionbd.getConnection()) {
                        if (conn != null) {
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(
                                "SELECT DISTINCT puesto FROM registro_votantes " +
                                "WHERE puesto IS NOT NULL AND puesto <> '' ORDER BY puesto ASC"
                            );

                            while (rs.next()) {
                                String puesto = rs.getString("puesto");
                %>
                                <label>
                                    <input type="checkbox" name="puestos" value="<%=puesto%>" onclick="updateSelectAll()"> 
                                    <%=puesto%>
                                </label>
                <%
                            }
                            rs.close();
                            stmt.close();
                        } else {
                            out.println("<span style='color:red;'>No se pudo conectar a la base de datos.</span>");
                        }
                    } catch (Exception e) {
                        out.println("<span style='color:red;'>Error al cargar puestos: " + e.getMessage() + "</span>");
                    }
                %>
            </div>
        </div>

        <div class="btn-container">
            <button type="submit" name="accion" value="consultarSeleccion">Consultar</button>
            <button type="submit" name="accion" value="mayorCantidad">Mayor</button>
            <button type="submit" name="accion" value="menorCantidad">Menor</button>
            <button type="button" onclick="window.location.href='buscar_lider.jsp'">Regresar</button>
        </div>
    </form>

    <% 
        String resultado = (String) request.getAttribute("resultado");
        if (resultado != null) { 
    %>
        <div class="resultado">
            <strong>Resultado:</strong><br>
            <%= resultado %>
        </div>
    <% } %>

    <!-- 📜 Script para desplegable y selección múltiple -->
    <script>
        let expanded = false;

        function toggleCheckboxes() {
            const checkboxes = document.getElementById("checkboxes");
            checkboxes.style.display = expanded ? "none" : "block";
            expanded = !expanded;
        }

        function toggleSelectAll(source) {
            const checkboxes = document.querySelectorAll('#checkboxes input[type="checkbox"][name="puestos"]');
            checkboxes.forEach(cb => cb.checked = source.checked);
        }

        function updateSelectAll() {
            const all = document.querySelectorAll('#checkboxes input[type="checkbox"][name="puestos"]');
            const allChecked = Array.from(all).every(cb => cb.checked);
            document.getElementById("selectAll").checked = allChecked;
        }

        document.addEventListener("click", function (e) {
            if (!e.target.closest(".custom-select")) {
                document.getElementById("checkboxes").style.display = "none";
                expanded = false;
            }
        });
    </script>
</body>
</html>
