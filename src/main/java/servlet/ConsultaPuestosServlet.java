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

import conection.conexionbd; // ✅ Importamos tu clase de conexión centralizada

@WebServlet("/ConsultaPuestosServlet")
public class ConsultaPuestosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String resultado = "";

        try (Connection conn = conexionbd.getConnection()) { // ✅ Usamos tu clase conexionbd

            if (conn == null) {
                request.setAttribute("resultado", "No se pudo establecer conexión con la base de datos.");
                request.getRequestDispatcher("modulo_puestos.jsp").forward(request, response);
                return;
            }

            if ("consultarSeleccion".equals(accion)) {
                String[] puestosSeleccionados = request.getParameterValues("puestos");

                if (puestosSeleccionados != null && puestosSeleccionados.length > 0) {
                    // 🔹 Generar placeholders dinámicos (?, ?, ?)
                    String placeholders = String.join(",", Collections.nCopies(puestosSeleccionados.length, "?"));
                    String sql = "SELECT puesto, COUNT(*) AS total FROM registro_votantes WHERE puesto IN (" 
                               + placeholders + ") GROUP BY puesto";

                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        for (int i = 0; i < puestosSeleccionados.length; i++) {
                            pstmt.setString(i + 1, puestosSeleccionados[i]);
                        }

                        try (ResultSet rs = pstmt.executeQuery()) {
                            StringBuilder sb = new StringBuilder();
                            while (rs.next()) {
                                sb.append("Puesto: ").append(rs.getString("puesto"))
                                  .append(" → Registros: ").append(rs.getInt("total")).append("<br>");
                            }
                            resultado = sb.toString();
                        }
                    }
                } else {
                    resultado = "No seleccionaste ningún puesto.";
                }

            } else if ("mayorCantidad".equals(accion)) {
                String sql = "SELECT puesto, COUNT(*) AS total FROM registro_votantes GROUP BY puesto ORDER BY total DESC LIMIT 1";

                try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                    if (rs.next()) {
                        resultado = "Puesto con más registros: " + rs.getString("puesto") +
                                    " → Registros: " + rs.getInt("total");
                    } else {
                        resultado = "No hay datos en la base.";
                    }
                }

            } else if ("menorCantidad".equals(accion)) {
                // 🔹 Consultar el valor mínimo de registros
                String sqlMin = "SELECT MIN(total) AS minTotal FROM (SELECT COUNT(*) AS total FROM registro_votantes GROUP BY puesto) AS subquery";

                int minTotal = -1;
                try (Statement stmtMin = conn.createStatement(); ResultSet rsMin = stmtMin.executeQuery(sqlMin)) {
                    if (rsMin.next()) {
                        minTotal = rsMin.getInt("minTotal");
                    }
                }

                if (minTotal != -1) {
                    String sql = "SELECT puesto FROM registro_votantes GROUP BY puesto HAVING COUNT(*) = ?";
                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        pstmt.setInt(1, minTotal);

                        try (ResultSet rs = pstmt.executeQuery()) {
                            StringBuilder sb = new StringBuilder();
                            sb.append("Puestos con menos registros (").append(minTotal).append("):<br>");
                            while (rs.next()) {
                                sb.append("• ").append(rs.getString("puesto")).append("<br>");
                            }
                            resultado = sb.toString();
                        }
                    }
                } else {
                    resultado = "No hay datos suficientes para calcular el mínimo.";
                }
            } else {
                resultado = "Acción no reconocida.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            resultado = "Error: " + e.getMessage();
        }

        // 🔹 Enviar resultado a la JSP
        request.setAttribute("resultado", resultado);
        request.getRequestDispatcher("modulo_puestos.jsp").forward(request, response);
    }
}
