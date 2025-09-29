/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import conection.conexionbd; // ✅ Importa la clase de conexión

@WebServlet("/exportarExcel")
public class ExportarExcelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Leer parámetros
        String lider = request.getParameter("lider");
        String puesto = request.getParameter("puesto");
        String mesa = request.getParameter("mesa");

        // Construir mapa de criterios
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

        if (criterios.isEmpty()) {
            response.setContentType("text/plain");
            response.getWriter().write("Debe proporcionar al menos un criterio de búsqueda (lider, puesto o mesa).");
            return;
        }

        try (Connection con = conexionbd.getConnection()) { // ✅ Usamos la clase conexionbd

            if (con == null) {
                response.setContentType("text/plain");
                response.getWriter().write("Error: No se pudo establecer conexión con la base de datos Railway.");
                return;
            }

            // Construir consulta SQL dinámica
            StringBuilder sql = new StringBuilder("SELECT * FROM registro_votantes WHERE ");
            boolean primero = true;
            for (String campo : criterios.keySet()) {
                if (!primero) sql.append(" AND ");
                sql.append(campo).append(" = ?");
                primero = false;
            }

            try (PreparedStatement ps = con.prepareStatement(sql.toString())) {
                int index = 1;
                for (String valor : criterios.values()) {
                    ps.setString(index++, valor);
                }

                try (ResultSet rs = ps.executeQuery()) {

                    // Crear archivo Excel
                    XSSFWorkbook workbook = new XSSFWorkbook();
                    Sheet sheet = workbook.createSheet("Votantes");

                    // Encabezado
                    Row header = sheet.createRow(0);
                    ResultSetMetaData meta = rs.getMetaData();
                    int columnCount = meta.getColumnCount();
                    for (int i = 1; i <= columnCount; i++) {
                        header.createCell(i - 1).setCellValue(meta.getColumnName(i));
                    }

                    // Filas
                    int rowIndex = 1;
                    while (rs.next()) {
                        Row row = sheet.createRow(rowIndex++);
                        for (int i = 1; i <= columnCount; i++) {
                            row.createCell(i - 1).setCellValue(rs.getString(i));
                        }
                    }

                    // Configuración de la respuesta
                    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                    String nombreArchivo = criterios.isEmpty()
                            ? "votantes.xlsx"
                            : "votantes_filtrado.xlsx";
                    response.setHeader("Content-Disposition", "attachment; filename=\"" + nombreArchivo + "\"");

                    try (OutputStream out = response.getOutputStream()) {
                        workbook.write(out);
                    }

                    workbook.close();
                }
            }

        } catch (Exception e) {
            response.setContentType("text/plain");
            response.getWriter().write("Error al exportar a Excel: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
