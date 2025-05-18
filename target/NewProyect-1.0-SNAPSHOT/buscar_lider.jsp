<%-- 
    Document   : buscar_lider
    Created on : 18/05/2025, 4:24:39 p. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Buscar Líder</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0;
            }

            h2 {
                text-align: center;
                color: #2f3640;
            }

            form {
                width: 90%;
                max-width: 500px;
                margin: 30px auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #353b48;
            }

            input[type="text"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #dcdde1;
                border-radius: 8px;
                margin-bottom: 15px;
            }

            button {
                background-color: #00a8ff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #0097e6;
            }
        </style>
    </head>
    <body>
        <h2>Buscar Información del Líder</h2>

        <form method="POST" action="buscarLider">
            <label for="lider">Nombre del líder:</label>
            <input type="text" id="lider" name="lider" required>
            <button type="submit">Buscar</button>
        </form>


    </body>
</html>
