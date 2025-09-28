/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package conection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase para gestionar la conexión a la base de datos en Railway usando variable de entorno
 */
public class conexionbd {

    private static Connection con = null;

    public static Connection getConnection() {
        if (con == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                // 🔹 Leer la URL desde variable de entorno
                String url = System.getenv("DATABASE_URL");

                if (url == null) {
                    System.err.println("⚠️ La variable DATABASE_URL no está configurada en Railway.");
                    return null;
                }

                con = DriverManager.getConnection(url);
                System.out.println("✅ Conexión exitosa usando variable de entorno Railway");

            } catch (ClassNotFoundException | SQLException e) {
                System.err.println("❌ Error en la conexión: " + e.getMessage());
            }
        }
        return con;
    }
}

