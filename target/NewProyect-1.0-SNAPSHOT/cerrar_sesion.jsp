<%-- 
    Document   : cerrar_sesion
    Created on : 30/05/2025, 10:30:52 a. m.
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // Eliminar sesión
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    response.sendRedirect("Login.jsp"); // Redirigir al login
%>
