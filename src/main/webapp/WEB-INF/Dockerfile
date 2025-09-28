# Usa Tomcat con Java 17
FROM tomcat:10.1-jdk17

# Elimina las apps por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia tu WAR al Tomcat
COPY target/NewProyect-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expone el puerto
EXPOSE 8080

# Inicia Tomcat
CMD ["catalina.sh", "run"]
