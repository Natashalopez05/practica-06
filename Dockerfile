FROM gradle:8.5-jdk21 AS build
WORKDIR /home/gradle/src
COPY --chown=gradle:gradle . .
RUN gradle bootJar --no-daemon

FROM eclipse-temurin:21-jre-alpine

ENV SERVER_PORT=8080
WORKDIR /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/practica-4.jar

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "exec java -jar /app/practica-4.jar --server.port=${SERVER_PORT}"]