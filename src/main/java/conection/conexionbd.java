/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package conection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase para gestionar la conexión a la base de datos Railway (MySQL)
 */
public class conexionbd {

    private Connection con;

    public conexionbd() {
        try {
            // 1️⃣ Cargar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2️⃣ Parámetros de conexión (copiados desde Railway)
            String url = "jdbc:mysql://shortline.proxy.rlwy.net:50047/railway"
                       + "?useSSL=true"
                       + "&requireSSL=false"
                       + "&allowPublicKeyRetrieval=true"
                       + "&serverTimezone=UTC";

            String user = "root";
            String password = "pqmvrNBzsrqytjwxEUqulHeULDKxwuSJ";

            // 3️⃣ Crear la conexión
            con = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Conexión exitosa a la base de datos Railway.");

        } catch (ClassNotFoundException e) {
            System.err.println("❌ Error: No se encontró el driver de MySQL (mysql-connector-j).");
            e.printStackTrace();

        } catch (SQLException e) {
            System.err.println("❌ Error al conectar con la base de datos:");
            e.printStackTrace(); // imprime toda la traza del error (útil para diagnosticar)
        }
    }

    // 4️⃣ Retorna la conexión activa
    public Connection getConection() {
        return con;
    }

    // 5️⃣ Método estático para obtener una conexión rápida
    public static Connection getConnection() {
        conexionbd conexion = new conexionbd();
        return conexion.getConection();
    }

    // 6️⃣ Cerrar la conexión
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
