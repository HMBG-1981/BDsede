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

@WebServlet("/EditarRegistroServlet")
public class EditarRegistroServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cedula = request.getParameter("cedula");
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String puesto = request.getParameter("puesto");
        String mesa = request.getParameter("mesa");
        String ciudad = request.getParameter("ciudad");
        String lider = request.getParameter("lider");
        String observacion = request.getParameter("observacion");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BDsede", "root", "1981bcG@");

            String sql = "UPDATE registro_votantes SET Nombre=?, Direccion=?, Telefono=?, Puesto=?, Mesa=?, Ciudad=?, Lider=?, Observacion=? WHERE Cedula=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, direccion);
            ps.setString(3, telefono);
            ps.setString(4, puesto);
            ps.setString(5, mesa);
            ps.setString(6, ciudad);
            ps.setString(7, lider);
            ps.setString(8, observacion);
            ps.setString(9, cedula);

            int filas = ps.executeUpdate();
            ps.close();
            conn.close();

            if (filas > 0) {
                response.sendRedirect("editar_votante.jsp?mensaje=actualizado");
            } else {
                response.sendRedirect("editar_votante.jsp?mensaje=error");
            }

        } catch (Exception e) {
            response.sendRedirect("editar_votante.jsp?mensaje=error");
        }
    }
}
