/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import conection.conexionbd; // ✅ Importamos tu clase de conexión

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UsuariosServlet")
public class UsuariosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔹 Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String cedula = request.getParameter("cedula");
        String telefono = request.getParameter("telefono");
        String contrasena = request.getParameter("contrasena");

        // 🧠 Depuración: mostrar datos en consola (solo para pruebas)
        System.out.println("Nombre: " + nombre);
        System.out.println("Cédula: " + cedula);
        System.out.println("Teléfono: " + telefono);

        // 🔹 Conexión usando tu clase personalizada
        try (Connection con = conexionbd.getConnection()) {

            if (con == null) {
                response.sendRedirect("registro_usuarios.jsp?mensaje=No se pudo establecer conexión con la base de datos");
                return;
            }

            // 🔹 Preparar sentencia SQL
            String sql = "INSERT INTO usuarios (nombre, direccion, cedula, telefono, contrasena) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, nombre);
                ps.setString(2, direccion);
                ps.setString(3, cedula);
                ps.setString(4, telefono);
                ps.setString(5, contrasena); // ⚠️ En producción, deberías cifrarla antes

                int result = ps.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("bienvenida.jsp?mensaje=Registro exitoso");
                } else {
                    response.sendRedirect("registro_usuarios.jsp?mensaje=Error al registrar");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registro_usuarios.jsp?mensaje=Error: " + e.getMessage());
        }
    }
}
