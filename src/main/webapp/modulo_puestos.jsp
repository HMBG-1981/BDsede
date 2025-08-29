<%-- 
    Document   : modulo_puestos
    Created on : 11/06/2025, 9:22:51 a. m.
    Author     : Administrador
--%>

<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Módulo de Consulta de Puestos</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: url(img/Fondo.png);
                margin: 0;
                padding: 0;
            }

            h2 {
                margin-top: 7%;
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
                max-width: 600px;
                margin: 30px auto;
                margin-top: 3%;
                padding: 20px;
                background: linear-gradient(135deg, #0d6efd, #d9534f);
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                color: white;
                position: relative;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: black;
            }

            .custom-select {
                position: relative;
                width: 100%;
                margin-bottom: 15px;
            }

            .select-box {
                background-color: #fff;
                border: 1px solid #dcdde1;
                border-radius: 8px;
                padding: 10px;
                cursor: pointer;
                font-size: 16px;
                color: black;
            }

            #checkboxes {
                display: none;
                border: 1px solid #dcdde1;
                border-radius: 8px;
                padding: 10px;
                background-color: white;
                position: absolute;
                width: 100%;
                max-height: 150px;
                overflow-y: auto;
                z-index: 10;
            }

            #checkboxes label {
                color: black;
                margin-bottom: 5px;
                display: block;
                font-weight: normal;
            }

            .btn-container {
                display: flex;
                flex-wrap: nowrap;
                justify-content: space-between;
                gap: 10px;
                margin-top: 15px;
            }

            .btn-container button {
                flex: 1 1 auto;
                width: 24%;
                background-color: red;
                color: white;
                padding: 12px 0;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                font-size: 15px;
                text-align: center;
            }

            .btn-container button:hover {
                background-color: green;
            }

            .resultado {
                width: 90%;
                max-width: 600px;
                margin: 20px auto;
                background: #fff;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.2);
                color: #333;
                font-size: 16px;
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
                    <label><input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)"> Seleccionar todos</label>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection(
                                    "jdbc:mysql://localhost:3306/BDsede", "root", "1981bcG");

                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT DISTINCT puesto FROM registro_votantes");

                                while (rs.next()) {
                                    String puesto = rs.getString("puesto");
                        %>
                    <label><input type="checkbox" name="puestos" value="<%=puesto%>" onclick="updateSelectAll()"> <%=puesto%></label>
                        <%
                                }
                                rs.close();
                                conn.close();
                            } catch (Exception e) {
                                out.println("Error al cargar puestos: " + e.getMessage());
                            }
                        %>
                </div>
            </div>

            <div class="btn-container">
                <button type="submit" name="accion" value="consultarSeleccion">Consultar</button>
                <button type="submit" name="accion" value="mayorCantidad">Mayor</button>
                <button type="submit" name="accion" value="menorCantidad">Menor</button>
                <button type="button" onclick="window.location.href = 'buscar_lider.jsp'">Regresar</button>
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
        <%
            }
        %>

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



