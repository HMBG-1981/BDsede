/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cedula = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // Configuración de conexión (ajusta con tus datos reales)
        String url = "jdbc:mysql://localhost:3306/BDsede";
        String dbUser = "root";              // ← Cambia esto a tu usuario real
        String dbPassword = "1981bcG";      // ← Cambia esto a tu contraseña real

        try {
            // Cargar el driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establecer conexión
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Consulta SQL para verificar usuario
            String sql = "SELECT * FROM usuarios WHERE cedula = ? AND contrasena = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, cedula);
            stmt.setString(2, contrasena);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Usuario autenticado
                String nombre = rs.getString("nombre"); // ← Asegúrate de que tu tabla tenga esta columna

                HttpSession session = request.getSession();
                session.setAttribute("cedula", cedula);
                session.setAttribute("nombre", nombre); // ← Guarda el nombre para mostrarlo luego

                // Redirigir a la página de bienvenida
                response.sendRedirect("bienvenida.jsp");
            } else {
                // Usuario no encontrado
                response.sendRedirect("Login.jsp?mensaje=Usuario o clave incorrectos.");
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Login.jsp?mensaje=Error al conectar con la base de datos.");
        }
    }
}
