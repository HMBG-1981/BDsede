/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package conection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase para gestionar la conexión a la base de datos en Railway
 */
public class conexionbd {

    // 🔹 Datos de conexión proporcionados por Railway
    private static final String URL = "jdbc:mysql://mysql.railway.internal:3306/railway?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "pqmvrNBzsrqytjwxEUqulHeULDKxwuSJ";

    private Connection con;

    public conexionbd() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Conexión exitosa a la base de datos Railway");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("❌ Error en la conexión: " + e.getMessage());
        }
    }

    public Connection getConection() {
        return con;
    }

    public static Connection getConnection() {
        conexionbd conexion = new conexionbd();
        return conexion.getConection();
    }
}
