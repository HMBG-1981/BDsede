<%-- 
    Document   : buscar_lider
    Created on : 18/05/2025, 4:24:39 p. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> <%-- Define el tipo de contenido como HTML y la codificación como UTF-8 --%>
<%@ page import="java.sql.*" %> <%-- Importa clases necesarias para conectarse y trabajar con bases de datos --%>
<!DOCTYPE html>
<html lang="es"> <%-- Inicia el documento HTML y especifica que el lenguaje es español --%>
    <head>
        <meta charset="UTF-8"> <%-- Define la codificación de caracteres del documento --%>
        <title>Buscar Líder</title> <%-- Título que aparece en la pestaña del navegador --%>
        <style> <%-- Inicio del bloque de estilos CSS --%>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: url(img/bandera.jpg);
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
                background-color: #0097e6;
            }

            .exportar-btn {
                background-color: #28a745;
            }

            .exportar-btn:hover {
                background-color: #218838;
            }
        </style> <%-- Fin del bloque de estilos --%>
    </head>
    <body>
        <h2>FILTRO GENERAL DE INFORMACIÓN</h2> <%-- Título principal de la página --%>

        <form action="buscarVotante" method="post"> <%-- Inicia el formulario que enviará datos al servlet "buscarVotante" --%>

            <!-- Campo líder -->
            <label for="lider">Líder:</label> <%-- Etiqueta del campo líder --%>
            <select name="lider" id="lider"> <%-- Menú desplegable para seleccionar líder --%>
                <option value="">-- Seleccione un líder --</option> <%-- Opción por defecto --%>
                <%
                    try {
                        // Cargar el driver de MySQL
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establecer conexión con la base de datos
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdsede", "root", "1981bcG@");

                        // Crear objeto Statement para ejecutar consultas
                        Statement stmt = con.createStatement();

                        // Ejecutar consulta SQL para obtener los líderes únicos
                        ResultSet rs = stmt.executeQuery("SELECT DISTINCT lider FROM registro_votantes ORDER BY lider");

                        // Recorrer los resultados y agregar cada líder como opción en el select
                        while (rs.next()) {
                            String valor = rs.getString("lider");
                %>
                <option value="<%= valor %>"><%= valor %></option> <%-- Opción generada dinámicamente --%>
                <%
                        }

                        // Cerrar conexiones y recursos
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("<option>Error al cargar líderes</option>"); // Mostrar error si ocurre una excepción
                    }
                %>
            </select>

            <!-- Campo puesto -->
            <label for="puesto">Puesto:</label>
            <select name="puesto" id="puesto">
                <option value="">-- Seleccione un puesto --</option>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdsede", "root", "1981bcG@");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT DISTINCT puesto FROM registro_votantes ORDER BY puesto");
                        while (rs.next()) {
                            String valor = rs.getString("puesto");
                %>
                <option value="<%= valor %>"><%= valor %></option>
                <%
                        }
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("<option>Error al cargar puestos</option>");
                    }
                %>
            </select>

            <!-- Campo mesa con valores fijos del 1 al 50 -->
            <label for="mesa">Mesa:</label>
            <select name="mesa" id="mesa">
                <option value="">-- Seleccione una mesa --</option>
                <%
                    // Generar opciones del 1 al 50 con un bucle for
                    for (int i = 1; i <= 50; i++) {
                %>
                <option value="<%= i %>"><%= i %></option> <%-- Cada número del 1 al 50 como opción --%>
                <%
                    }
                %>
            </select>

            <!-- Botones -->
            <div class="btn-container"> <%-- Contenedor para los botones con diseño flexible --%>
                <button type="submit">Buscar</button> <%-- Botón para enviar el formulario --%>
                <button type="submit" formaction="exportarExcel" formmethod="get" class="exportar-btn">Exportar Excel</button> <%-- Botón para exportar resultados --%>
                <button type="button" class="btn-buscar" onclick="window.location.href = 'Registro.jsp'">Regresar</button>
            </div>
        </form>
    </body>
</html>
