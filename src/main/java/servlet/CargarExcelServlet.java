/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import conection.conexionbd;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.sql.*;

@WebServlet("/CargarExcelServlet")
@MultipartConfig
public class CargarExcelServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("archivoExcel");
        InputStream fileContent = filePart.getInputStream();

        try (Workbook workbook = new XSSFWorkbook(fileContent)) {
            Sheet sheet = workbook.getSheetAt(0);

            Connection conn = conexionbd.getConnection();
            PreparedStatement stmt;

            String sql = "INSERT INTO registro_votantes " +
                    "(nombre, cedula, direccion, telefono, puesto, mesa, ciudad, lider, observacion) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                stmt = conn.prepareStatement(sql);
                stmt.setString(1, getCellValue(row.getCell(0)));
                stmt.setString(2, getCellValue(row.getCell(1)));
                stmt.setString(3, getCellValue(row.getCell(2)));
                stmt.setString(4, getCellValue(row.getCell(3)));
                stmt.setString(5, getCellValue(row.getCell(4)));
                stmt.setString(6, getCellValue(row.getCell(5)));
                stmt.setString(7, getCellValue(row.getCell(6)));
                stmt.setString(8, getCellValue(row.getCell(7)));
                stmt.setString(9, getCellValue(row.getCell(8)));
                stmt.executeUpdate();
                stmt.close();
            }

            conn.close();
            response.sendRedirect("otros/registro_exitoso.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al procesar el archivo Excel: " + e.getMessage());
        }
    }

    private String getCellValue(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING: return cell.getStringCellValue().trim();
            case NUMERIC: return String.valueOf((long) cell.getNumericCellValue());
            case BOOLEAN: return String.valueOf(cell.getBooleanCellValue());
            default: return "";
        }
    }
}
