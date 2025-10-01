/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import conection.conexionbd; // Importamos tu clase de conexión personalizada
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/registroLiderServlet")
public class registroLiderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Capturar parámetros del formulario
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String cedula = request.getParameter("cedula");
        String telefono = request.getParameter("telefono");

        Connection con = null;

        try {
            // Obtener conexión desde la clase conexionbd
            con = conexionbd.getConnection();

            // Validar conexión
            if (con == null) {
                throw new Exception("No se pudo establecer la conexión con la base de datos.");
            }

            // Consulta SQL
            String sql = "INSERT INTO lideres (nombre, direccion, cedula, telefono) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, direccion);
            ps.setString(3, cedula);
            ps.setString(4, telefono);

            // Ejecutar inserción
            int result = ps.executeUpdate();

            // Redirigir con mensaje según el resultado
            if (result > 0) {
                response.sendRedirect("registroLider.jsp?mensaje=Registro exitoso");
            } else {
                response.sendRedirect("registroLider.jsp?mensaje=Error al registrar");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registroLider.jsp?mensaje=Error: " + e.getMessage());
        } finally {
            // Cerrar conexión de forma segura
            try {
                if (con != null && !con.isClosed()) {
                    con.close();
                    System.out.println("🔒 Conexión cerrada correctamente (Servlet).");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
