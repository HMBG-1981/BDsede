/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import conection.conexionbd;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet para procesar el formulario de registro
 */
@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String cedula = request.getParameter("cedula");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String puesto = request.getParameter("puesto");
        String mesa = request.getParameter("mesa");
        String ciudad = request.getParameter("ciudad");
        String lider = request.getParameter("lider");
        String observacion = request.getParameter("observacion");

        // Conexión a la base de datos
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = conexionbd.getConnection();

            // Verificar si el número de documento ya existe en la tabla registro_votantes
            String sqlVerificar = "SELECT 1 FROM registro_votantes WHERE cedula = ?";
            stmt = conn.prepareStatement(sqlVerificar);
            stmt.setString(1, cedula);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Documento ya registrado
                response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Documento ya está registrado');");
                response.getWriter().println("location='Registro.jsp';"); // Cambia por la página adecuada
                response.getWriter().println("</script>");
            } else {
                // Cerrar stmt anterior y crear nuevo para el INSERT
                stmt.close();

                String sql = "INSERT INTO registro_votantes "
                        + "(nombre, cedula, direccion, telefono, puesto, mesa, ciudad, lider, observacion) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

                stmt = conn.prepareStatement(sql);
                stmt.setString(1, nombre);
                stmt.setString(2, cedula);
                stmt.setString(3, direccion);
                stmt.setString(4, telefono);
                stmt.setString(5, puesto);
                stmt.setString(6, mesa);
                stmt.setString(7, ciudad);
                stmt.setString(8, lider);
                stmt.setString(9, observacion);

                stmt.executeUpdate();

                // Redireccionar si fue exitoso
                response.sendRedirect("otros/registro_exitoso.jsp");
            }

        } catch (SQLException e) {
            response.getWriter().println("Error al registrar: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
            }
        }
    }
}

