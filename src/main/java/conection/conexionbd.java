/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package conection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexionbd {

    private Connection con;

    public conexionbd() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://shortline.proxy.rlwy.net:50047/railway"
                       + "?useSSL=true"
                       + "&requireSSL=false"
                       + "&allowPublicKeyRetrieval=true"
                       + "&serverTimezone=UTC";

            String user = "root";
            String password = "pqmvrNBzsrqytjwxEUqulHeULDKxwuSJ";

            con = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Conexión exitosa a la base de datos Railway.");

        } catch (ClassNotFoundException e) {
            System.err.println("❌ No se encontró el driver MySQL.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Error al conectar con la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public Connection getConection() {
        return con;
    }

    public static Connection getConnection() {
        conexionbd conexion = new conexionbd();
        return conexion.getConection();
    }

    public void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                System.out.println("🔒 Conexión cerrada correctamente.");
            }
        } catch (SQLException e) {
            System.err.println("⚠️ Error al cerrar la conexión:");
            e.printStackTrace();
        }
    }
}
