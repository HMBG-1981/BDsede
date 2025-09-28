# Imagen base de Tomcat
FROM tomcat:10.1-jdk17

# Elimina la app por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia tu WAR al servidor Tomcat
COPY dist/NewProyect-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expone el puerto
EXPOSE 8080

# Ejecuta Tomcat
CMD ["catalina.sh", "run"]