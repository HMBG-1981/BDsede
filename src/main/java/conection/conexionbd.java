/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package conection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase de conexión a la base de datos MySQL (Railway)
 */
public class conexionbd {

    private Connection con;

    public conexionbd() {
        try {
            // Cargar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // URL de conexión Railway (ajusta si cambian los datos)
            String url = "jdbc:mysql://shortline.proxy.rlwy.net:50047/railway"
                       + "?useSSL=true"
                       + "&requireSSL=false"
                       + "&allowPublicKeyRetrieval=true"
                       + "&serverTimezone=UTC";

            // Credenciales de Railway
            String user = "root";
            String password = "pqmvrNBzsrqytjwxEUqulHeULDKxwuSJ";

            // Establecer la conexión
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

    /**
     * Retorna la conexión activa
     */
    public Connection getConnectionInstance() {
        return con;
    }

    /**
     * Método estático para obtener conexión
     */
    public static Connection getConnection() {
        conexionbd conexion = new conexionbd();
        return conexion.getConnectionInstance();
    }

    /**
     * Cierra la conexión si está abierta
     */
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
