# ==========================================
# Stage 1: Build — Maven + JDK 17 Alpine
# ==========================================
FROM maven:3.9-eclipse-temurin-17-alpine AS builder

WORKDIR /app

# Copiar el descriptor de dependencias primero (cache de capas de Maven)
COPY pom.xml .
COPY .mvn/ .mvn/
COPY mvnw mvnw.cmd ./

# Descargar dependencias sin compilar (aprovecha caché si pom.xml no cambia)
RUN mvn dependency:go-offline -B

# Copiar el código fuente y compilar
COPY src/ src/
RUN mvn clean package -DskipTests -B

# ==========================================
# Stage 2: Runtime — JRE 17 Alpine (imagen minimalista)
# ==========================================
FROM eclipse-temurin:17-jre-alpine AS runner

# Crear usuario no-root para mayor seguridad
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copiar el JAR generado en la etapa de build
COPY --from=builder /app/target/*.jar app.jar

# Cambiar al usuario no-root
USER appuser

# Exponer el puerto del backend de Ventas
EXPOSE 8080

# Variables de entorno (serán inyectadas por Docker Compose / ECS)
ENV DB_ENDPOINT=localhost \
    DB_PORT=3306 \
    DB_NAME=ventasdb \
    DB_USERNAME=root \
    DB_PASSWORD=secret

# Punto de entrada con configuración de JVM optimizada para contenedores
ENTRYPOINT ["java", \
  "-XX:+UseContainerSupport", \
  "-XX:MaxRAMPercentage=75.0", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-jar", "app.jar"]
