#Stage 1 Build
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

#Stage 2 Runtime
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/handler-service-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 9091
ENV PROCESSOR_URL=http://processor:9090/process
ENTRYPOINT [ "java","-jar","app.jar" ]
