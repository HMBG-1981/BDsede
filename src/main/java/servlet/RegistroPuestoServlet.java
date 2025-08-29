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

@WebServlet("/RegistroPuestoServlet")
public class RegistroPuestoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");

        String url = "jdbc:mysql://localhost:3306/BDsede";
        String user = "root"; // Cambia según tu configuración
        String pass = "1981bcG";     // Cambia según tu configuración

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);

            String sql = "INSERT INTO puestoVotacion (nombre) VALUES (?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("registroPuesto.jsp?mensaje=Registro Exitoso");
            } else {
                response.sendRedirect("registroPuesto.jsp?mensaje=Error al registrar");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registroPuesto.jsp?mensaje=Error: " + e.getMessage());
        }
    }
}
