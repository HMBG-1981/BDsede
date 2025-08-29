/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet("/CargarLiderServlet")
@MultipartConfig
public class CargarLiderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("archivoExcel");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        int registrosInsertados = 0;

        String url = "jdbc:mysql://localhost:3306/BDsede";
        String user = "root";
        String pass = "1981bcG";

        try (FileInputStream fis = new FileInputStream(new File(filePath));
             Workbook workbook = new XSSFWorkbook(fis)) {

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(url, user, pass)) {
                Sheet sheet = workbook.getSheetAt(0);

                String sql = "INSERT INTO lideres (nombre, direccion, cedula, telefono) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);

                for (Row row : sheet) {
                    if (row.getRowNum() == 0) continue; // saltar cabecera

                    String nombre = getCellValue(row.getCell(0));
                    String direccion = getCellValue(row.getCell(1));
                    String cedula = getCellValue(row.getCell(2));
                    String telefono = getCellValue(row.getCell(3));

                    if (nombre != null && !nombre.trim().isEmpty()) {
                        ps.setString(1, nombre);
                        ps.setString(2, direccion);
                        ps.setString(3, cedula);
                        ps.setString(4, telefono);
                        registrosInsertados += ps.executeUpdate();
                    }
                }

                ps.close();
                response.sendRedirect("registroLider.jsp?mensaje=Se insertaron " + registrosInsertados + " registros");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registroLider.jsp?mensaje=Error al cargar Excel: " + e.getMessage());
        }
    }

    // 🔹 Método auxiliar para manejar celdas de cualquier tipo
    private String getCellValue(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toString();
                } else {
                    return String.valueOf((long) cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
    }
}
