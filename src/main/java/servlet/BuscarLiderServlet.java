/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/buscarLider")
public class BuscarLiderServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bdsede";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "1981bcG@";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String nombreLider = request.getParameter("lider");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

            String sql = "SELECT * FROM registro_votantes WHERE lider = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombreLider);

            ResultSet rs = ps.executeQuery();

            out.println("<html><head><title>Resultado Lider</title>");
            out.println("<style>");
            out.println("body {");
            out.println("  background: linear-gradient(to bottom right, red, blue);");
            out.println("  color: white;");  // opcional: texto blanco para mejor contraste
            out.println("  font-family: Arial, sans-serif;");
            out.println("}");
            out.println("table { background-color: rgba(255, 255, 255, 0.9); color: black; }"); // para que la tabla sea legible
            out.println("th, td { padding: 8px; }");
            out.println("</style>");
            out.println("</head><body>");

            out.println("<h2>Resultados para: " + nombreLider + "</h2>");

            if (!rs.isBeforeFirst()) {
                out.println("<p>No se encontraron resultados.</p>");
            } else {
                out.println("<table border='1' cellpadding='10'>");
                out.println("<tr>");

                int columnCount = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= columnCount; i++) {
                    out.println("<th>" + rs.getMetaData().getColumnName(i) + "</th>");
                }

                out.println("</tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    for (int i = 1; i <= columnCount; i++) {
                        out.println("<td>" + rs.getString(i) + "</td>");
                    }
                    out.println("</tr>");
                }
                out.println("</table>");
            }

            out.println("</body></html>");

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
