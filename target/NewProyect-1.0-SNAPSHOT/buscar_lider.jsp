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
                background: linear-gradient(135deg, #0d6efd, #d9534f); /* Azul a rojo */
                margin: 0;
                padding: 0;
            }

            h2 {
                text-align: center;
                color: red;
                text-shadow:
                    -1px -1px 0 black,
                    1px -1px 0 black,
                    -1px 1px 0 black,
                    1px 1px 0 black;    /* crea el efecto de delineado */
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
                color: red;
            }

            input[type="text"] {
                width: 95%;
                padding: 10px;
                border: 1px solid #dcdde1;
                border-radius: 8px;
                margin-bottom: 15px;
            }

            .btn-container {
                display: flex;
                justify-content: space-between;
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

            .exportar-btn {
                background-color: #28a745;
            }

            .exportar-btn:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <h2>FILTRO GENERAL DE INFORMACION 2025</h2>

        <!-- Formulario para búsqueda -->
        <form action="buscarVotante" method="post">
            <label>Líder:</label>
            <input type="text" name="lider" placeholder="Nombre del líder">

            <label>Puesto:</label>
            <input type="text" name="puesto" placeholder="Nombre del puesto">

            <label>Mesa:</label>
            <input type="text" name="mesa" placeholder="Número de mesa">

            <div class="btn-container">
                <button type="submit">Buscar</button>
                <!-- Botón para exportar -->
                <button type="submit" formaction="exportarExcel" formmethod="get" class="exportar-btn">Exportar Excel</button>
            </div>
        </form>
    </body>
</html>

