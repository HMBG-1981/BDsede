/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/buscarVotante")
public class BuscarVotanteServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bdsede";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "1981bcG@";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Recibir todos los posibles criterios
        String lider = request.getParameter("lider");
        String puesto = request.getParameter("puesto");
        String mesa = request.getParameter("mesa");

        // Crear mapa de criterios válidos
        Map<String, String> criterios = new LinkedHashMap<>();
        if (lider != null && !lider.trim().isEmpty()) {
            criterios.put("lider", lider.trim());
        }
        if (puesto != null && !puesto.trim().isEmpty()) {
            criterios.put("puesto", puesto.trim());
        }
        if (mesa != null && !mesa.trim().isEmpty()) {
            criterios.put("mesa", mesa.trim());
        }

        // Validar que haya al menos un criterio
        if (criterios.isEmpty()) {
            out.println("<p style='color:red;'>Debe ingresar al menos un criterio de búsqueda (lider, puesto o mesa).</p>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {

                // Construir la consulta SQL dinámicamente
                StringBuilder sql = new StringBuilder("SELECT * FROM registro_votantes WHERE ");
                boolean primero = true;

                for (String campo : criterios.keySet()) {
                    if (!primero) {
                        sql.append(" AND ");
                    }
                    sql.append(campo).append(" = ?");
                    primero = false;
                }

                try (PreparedStatement ps = con.prepareStatement(sql.toString())) {

                    int index = 1;
                    for (String valor : criterios.values()) {
                        ps.setString(index++, valor);
                    }

                    ResultSet rs = ps.executeQuery();

                    out.println("<html><head><title>Resultados de Búsqueda</title>");
                    out.println("<style>");
                    out.println("body { background: linear-gradient(to bottom right, red, blue); color: white; font-family: Arial; }");
                    out.println("table { background-color: rgba(255, 255, 255, 0.9); color: black; border-collapse: collapse; width: 100%; }");
                    out.println("th, td { border: 1px solid black; padding: 8px; }");
                    out.println("ul { list-style-type: square; }");
                    out.println("</style></head><body>");

                    out.println("<h2>Resultados de búsqueda</h2>");
                    out.println("<p><strong>Criterios de búsqueda:</strong></p>");
                    out.println("<ul>");
                    criterios.forEach((k, v) -> {
                        out.println("<li><strong>" + k + ":</strong> " + v + "</li>");
                    });
                    out.println("</ul>");

                    if (!rs.isBeforeFirst()) {
                        out.println("<p>No se encontraron registros para los criterios especificados.</p>");
                    } else {
                        out.println("<table>");
                        out.println("<tr>");
                        int columnCount = rs.getMetaData().getColumnCount();
                        for (int i = 1; i <= columnCount; i++) {
                            out.println("<th>" + rs.getMetaData().getColumnName(i) + "</th>");
                        }
                        out.println("</tr>");

                        int total = 0;
                        while (rs.next()) {
                            out.println("<tr>");
                            for (int i = 1; i <= columnCount; i++) {
                                out.println("<td>" + rs.getString(i) + "</td>");
                            }
                            out.println("</tr>");
                            total++;
                        }

                        out.println("<tr><td colspan='" + columnCount + "' style='text-align:right; font-weight:bold;'>");
                        out.println("Total de registros encontrados: " + total);
                        out.println("</td></tr>");
                        out.println("</table>");
                    }

                    out.println("</body></html>");
                    rs.close();
                }
            }

        } catch (ClassNotFoundException e) {
            out.println("<p style='color:red;'>Error: No se encontró el driver JDBC.</p>");
        } catch (SQLException e) {
            out.println("<p style='color:red;'>Error en la base de datos: " + e.getMessage() + "</p>");
        }
    }
}
