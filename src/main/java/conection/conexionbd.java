/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package conection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase para gestionar la conexión a la base de datos
 */
public class conexionbd {

    private Connection con;

    public conexionbd() {
        try {
            // Cargar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // URL, usuario y contraseña del servicio Railway
            String url = "jdbc:mysql://shortline.proxy.rlwy.net:50047/railway";
            String user = "root";
            String password = "pqmvrNBzsrqytjwxEUqulHeULDKxwuSJ";

            // Crear la conexión
            con = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Conexión exitosa a la base de datos Railway.");

        } catch (ClassNotFoundException e) {
            System.err.println("❌ Error: No se encontró el driver de MySQL.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Error al conectar con la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Retorna la conexión activa
    public Connection getConection() {
        return con;
    }

    // Método estático para obtener una conexión rápidamente
    public static Connection getConnection() {
        conexionbd conexion = new conexionbd();
        return conexion.getConection();
    }

    // Cerrar la conexión
    public void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                System.out.println("🔒 Conexión cerrada correctamente.");
            }
        } catch (SQLException e) {
            System.err.println("⚠️ Error al cerrar la conexión: " + e.getMessage());
        }
    }
}
