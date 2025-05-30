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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EliminarRegistroServlet")
public class EliminarRegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cedula = request.getParameter("cedula");
        String mensaje = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BDsede", "root", "1981bcG@");

            String sql = "DELETE FROM registro_votantes WHERE Cedula = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cedula);

            int filasAfectadas = ps.executeUpdate();
            mensaje = (filasAfectadas > 0) ? "eliminado" : "error";

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            mensaje = "error";
        }

        response.sendRedirect("editar_votante.jsp?mensaje=" + mensaje);
    }
}
