/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import conection.conexionbd; // ✅ Importamos la clase de conexión Railway

@WebServlet("/CargarLiderServlet")
@MultipartConfig
public class CargarLiderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("archivoExcel");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

        // 🔹 Crear carpeta uploads si no existe
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // 🔹 Guardar archivo en el servidor temporalmente
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        int registrosInsertados = 0;

        try (FileInputStream fis = new FileInputStream(new File(filePath)); Workbook workbook = new XSSFWorkbook(fis)) {

            // ✅ Obtener conexión desde la clase conexionbd (Railway)
            Connection con = conexionbd.getConnection();

            if (con == null) {
                throw new Exception("No se pudo establecer conexión con la base de datos.");
            }

            Sheet sheet = workbook.getSheetAt(0);
            String sql = "INSERT INTO lideres (nombre, direccion, cedula, telefono) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            for (Row row : sheet) {
                if (row.getRowNum() == 0) {
                    continue; // saltar cabecera
                }
                String nombre = getCellValue(row.getCell(0));
                String direccion = getCellValue(row.getCell(1));
                String cedula = getCellValue(row.getCell(2));
                String telefono = getCellValue(row.getCell(3));

                // Solo insertar si tiene nombre
                if (nombre != null && !nombre.trim().isEmpty()) {
                    ps.setString(1, nombre);
                    ps.setString(2, direccion);
                    ps.setString(3, cedula);
                    ps.setString(4, telefono);
                    registrosInsertados += ps.executeUpdate();
                }
            }

            ps.close();
            con.close();

            // Redirigir con mensaje de éxito
            response.sendRedirect("registroLider.jsp?mensaje=Se insertaron " + registrosInsertados + " registros correctamente.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registroLider.jsp?mensaje=❌ Error al cargar Excel: " + e.getMessage());
        }
    }

    // 🔹 Método auxiliar para obtener el valor de una celda en texto
    private String getCellValue(Cell cell) {
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toString();
                } else {
                    double val = cell.getNumericCellValue();
                    long longVal = (long) val;
                    if (val == longVal) {
                        return String.valueOf(longVal); // sin decimales
                    } else {
                        return String.valueOf(val);
                    }
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                try {
                    return cell.getStringCellValue();
                } catch (IllegalStateException e) {
                    return String.valueOf(cell.getNumericCellValue());
                }
            default:
                return "";
        }
    }
}
