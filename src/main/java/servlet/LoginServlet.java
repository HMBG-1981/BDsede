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
import conection.conexionbd; // 👈 Importamos tu clase de conexión

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Capturar los datos del formulario
        String cedula = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // 2️⃣ Declarar objetos JDBC
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // 3️⃣ Obtener conexión desde tu clase personalizada
            conn = conexionbd.getConnection();

            if (conn == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }

            // 4️⃣ Consulta SQL para verificar las credenciales
            String sql = "SELECT * FROM usuarios WHERE cedula = ? AND contrasena = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cedula);
            stmt.setString(2, contrasena);

            rs = stmt.executeQuery();

            if (rs.next()) {
                // ✅ Usuario autenticado correctamente
                String nombre = rs.getString("nombre"); // Asegúrate de que exista esta columna

                // Crear sesión y guardar datos
                HttpSession session = request.getSession();
                session.setAttribute("cedula", cedula);
                session.setAttribute("nombre", nombre);

                // Redirigir a la página de bienvenida
                response.sendRedirect("bienvenida.jsp");
            } else {
                // ⚠️ Usuario o contraseña incorrectos
                response.sendRedirect("Login.jsp?mensaje=Usuario o clave incorrectos.");
            }

        } catch (Exception e) {
            // 5️⃣ Manejo de errores
            e.printStackTrace();
            response.sendRedirect("Login.jsp?mensaje=Error al conectar con la base de datos.");
        } finally {
            // 6️⃣ Liberar recursos
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
