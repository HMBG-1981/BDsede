/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import conection.conexionbd; // ✅ Importamos tu clase de conexión

@WebServlet("/registroLiderServlet")
@MultipartConfig
public class registroLiderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // ✅ 1. Obtener conexión desde conexionbd
            con = conexionbd.getConnection();
            if (con == null) {
                throw new Exception("No se pudo conectar a la base de datos (conexionbd retornó null).");
            }

            // ✅ 2. Leer archivo Excel subido
            Part filePart = request.getPart("archivoExcel");
            InputStream fileContent = filePart.getInputStream();
            Workbook workbook = new XSSFWorkbook(fileContent);
            Sheet sheet = workbook.getSheetAt(0);

            // ✅ 3. Preparar consulta SQL
            String sql = "INSERT INTO lideres (nombre, direccion, cedula, telefono) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);

            int registrosExitosos = 0;

            // ✅ 4. Iterar filas (empezar desde la 2da, para saltar encabezado)
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                String nombre = getCellValue(row.getCell(0));
                String direccion = getCellValue(row.getCell(1));
                String cedula = getCellValue(row.getCell(2));
                String telefono = getCellValue(row.getCell(3));

                if (nombre == null || cedula == null || telefono == null) continue;

                ps.setString(1, nombre);
                ps.setString(2, direccion);
                ps.setString(3, cedula);
                ps.setString(4, telefono);
                ps.addBatch();

                registrosExitosos++;
            }

            // ✅ 5. Ejecutar inserciones en lote
            ps.executeBatch();
            workbook.close();

            // ✅ 6. Redirigir con mensaje de éxito
            response.sendRedirect("registroLider.jsp?mensaje=" + registrosExitosos + " registros cargados exitosamente.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registroLider.jsp?mensaje=Error al cargar Excel: " + e.getMessage());
        } finally {
            // ✅ 7. Cerrar recursos
            try {
                if (ps != null) ps.close();
                if (con != null && !con.isClosed()) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    // ✅ Método auxiliar para leer valores de celdas
    private String getCellValue(Cell cell) {
        if (cell == null) return null;
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                return String.valueOf((long) cell.getNumericCellValue());
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            default:
                return null;
        }
    }
}

