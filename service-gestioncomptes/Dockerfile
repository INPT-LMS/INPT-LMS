# Packaging de l'application Spring avec Maven
FROM maven:3.8.1-openjdk-11-slim AS MAVEN_PACKAGE
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp
RUN mvn package

# Transfert du .jar vers une image Java
FROM openjdk:11-jdk-slim
WORKDIR /app
ARG JAR_FILE=/tmp/target/*.jar
COPY --from=MAVEN_PACKAGE ${JAR_FILE} app.jar
ENTRYPOINT [ "java", "-jar", "app.jar" ]