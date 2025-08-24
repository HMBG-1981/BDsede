/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/ConsultaPuestosServlet")
public class ConsultaPuestosServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/BDsede";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "1981bcG";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String resultado = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            if ("consultarSeleccion".equals(accion)) {
                String[] puestosSeleccionados = request.getParameterValues("puestos");

                if (puestosSeleccionados != null && puestosSeleccionados.length > 0) {
                    String placeholders = String.join(",", Collections.nCopies(puestosSeleccionados.length, "?"));
                    String sql = "SELECT puesto, COUNT(*) as total FROM registro_votantes WHERE puesto IN (" + placeholders + ") GROUP BY puesto";

                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    for (int i = 0; i < puestosSeleccionados.length; i++) {
                        pstmt.setString(i + 1, puestosSeleccionados[i]);
                    }

                    ResultSet rs = pstmt.executeQuery();
                    StringBuilder sb = new StringBuilder();
                    while (rs.next()) {
                        sb.append("Puesto: ").append(rs.getString("puesto"))
                          .append(" → Registros: ").append(rs.getInt("total")).append("<br>");
                    }
                    resultado = sb.toString();
                    rs.close();
                    pstmt.close();
                } else {
                    resultado = "No seleccionaste ningún puesto.";
                }

            } else if ("mayorCantidad".equals(accion)) {
                String sql = "SELECT puesto, COUNT(*) as total FROM registro_votantes GROUP BY puesto ORDER BY total DESC LIMIT 1";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    resultado = "Puesto con más registros: " + rs.getString("puesto") +
                                " → Registros: " + rs.getInt("total");
                } else {
                    resultado = "No hay datos en la base.";
                }
                rs.close();
                stmt.close();

            } else if ("menorCantidad".equals(accion)) {
                String sqlMin = "SELECT MIN(total) as minTotal FROM (SELECT COUNT(*) as total FROM registro_votantes GROUP BY puesto) as subquery";
                Statement stmtMin = conn.createStatement();
                ResultSet rsMin = stmtMin.executeQuery(sqlMin);

                int minTotal = -1;
                if (rsMin.next()) {
                    minTotal = rsMin.getInt("minTotal");
                }
                rsMin.close();
                stmtMin.close();

                if (minTotal != -1) {
                    String sql = "SELECT puesto FROM registro_votantes GROUP BY puesto HAVING COUNT(*) = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, minTotal);
                    ResultSet rs = pstmt.executeQuery();

                    StringBuilder sb = new StringBuilder();
                    sb.append("Puestos con menos registros (").append(minTotal).append("):<br>");
                    while (rs.next()) {
                        sb.append("• ").append(rs.getString("puesto")).append("<br>");
                    }
                    resultado = sb.toString();
                    rs.close();
                    pstmt.close();
                } else {
                    resultado = "No hay datos suficientes para calcular el mínimo.";
                }
            }

            conn.close();
        } catch (Exception e) {
            resultado = "Error: " + e.getMessage();
        }

        request.setAttribute("resultado", resultado);
        request.getRequestDispatcher("modulo_puestos.jsp").forward(request, response);
    }
}
