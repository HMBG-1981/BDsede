/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/registroLiderServlet")
public class registroLiderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String cedula = request.getParameter("cedula");
        String telefono = request.getParameter("telefono");

        String url = "jdbc:mysql://localhost:3306/BDsede";
        String user = "root"; // Cambia según tu configuración
        String pass = "1981bcG";     // Cambia según tu configuración

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);

            String sql = "INSERT INTO lideres (nombre, direccion, cedula, telefono) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, direccion);
            ps.setString(3, cedula);
            ps.setString(4, telefono);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("registroLider.jsp?mensaje=Registro exitoso");
            } else {
                response.sendRedirect("registroLider.jsp?mensaje=Error al registrar");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registroLider.jsp?mensaje=Error: " + e.getMessage());
        }
    }
}
