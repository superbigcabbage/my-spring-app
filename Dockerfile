# 使用更通用的标签，避免极小的Alpine版本
FROM maven:3.8-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# 第二阶段：使用标准的JRE镜像而非Alpine
FROM eclipse-temurin:17-jre

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]