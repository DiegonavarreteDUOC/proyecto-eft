# 🚀 Sistema de Ventas y Despachos — Proyecto Semestral

> **ISY1101 — Introducción a Herramientas DevOps**  
> Evaluación Final Transversal (EFT) — 2025

[![CI/CD Frontend](https://github.com/TU_USUARIO/proyecto-eft/actions/workflows/ci-frontend.yml/badge.svg)](https://github.com/TU_USUARIO/proyecto-eft/actions/workflows/ci-frontend.yml)
[![CI/CD Ventas](https://github.com/TU_USUARIO/proyecto-eft/actions/workflows/ci-ventas.yml/badge.svg)](https://github.com/TU_USUARIO/proyecto-eft/actions/workflows/ci-ventas.yml)
[![CI/CD Despachos](https://github.com/TU_USUARIO/proyecto-eft/actions/workflows/ci-despachos.yml/badge.svg)](https://github.com/TU_USUARIO/proyecto-eft/actions/workflows/ci-despachos.yml)

---

## 📐 Arquitectura del Sistema

```
┌──────────────────────────────────────────────────────────────────┐
│                          INTERNET                                │
└──────────────────────────┬───────────────────────────────────────┘
                           │ :80
                    ┌──────▼──────┐
                    │  FRONTEND   │
                    │ React/Vite  │
                    │ Nginx:80    │
                    └──────┬──────┘
                           │ app-network
          ┌────────────────┼────────────────┐
          │                                 │
   ┌──────▼──────┐                  ┌───────▼──────┐
   │  BACK-VENTAS│                  │BACK-DESPACHOS│
   │ SpringBoot  │                  │ SpringBoot   │
   │  :8080      │                  │  :8081       │
   └──────┬──────┘                  └───────┬──────┘
          │                                 │
          └──────────────┬──────────────────┘
                  ┌──────▼──────┐
                  │   MySQL DB  │
                  │   :3306     │
                  └─────────────┘
```

## 📁 Estructura del Repositorio

```
proyecto-eft/
├── front_despacho/          # Frontend React + Vite + TailwindCSS
│   ├── Dockerfile           # Multistage: Node→Nginx
│   ├── nginx.conf           # Configuración Nginx SPA
│   └── src/
├── back-ventas/             # API REST Ventas (Spring Boot 3.4.4)
│   ├── Dockerfile           # Multistage: Maven→JRE-Alpine
│   └── src/
├── back-despachos/          # API REST Despachos (Spring Boot 3.4.4)
│   ├── Dockerfile           # Multistage: Maven→JRE-Alpine
│   └── src/
├── .github/
│   └── workflows/
│       ├── ci-ventas.yml    # Pipeline: build→test→push→deploy
│       ├── ci-despachos.yml # Pipeline: build→test→push→deploy
│       └── ci-frontend.yml  # Pipeline: build→push→deploy
├── docker-compose.yml       # Orquestación local completa
├── init.sql                 # Script inicial de base de datos
├── .env.example             # Plantilla de variables de entorno
└── README.md
```

---

## 🛠️ Tecnologías Utilizadas

| Componente | Tecnología | Versión |
|---|---|---|
| Frontend | React + Vite + TailwindCSS | 18.x / 5.x |
| Backend Ventas | Spring Boot + Java | 3.4.4 / 17 |
| Backend Despachos | Spring Boot + Java | 3.4.4 / 17 |
| Base de Datos | MySQL | 8.0 |
| Contenedores | Docker | 25+ |
| Orquestación local | Docker Compose | 2.x |
| CI/CD | GitHub Actions | — |
| Registro de imágenes | Docker Hub | — |
| Nube | AWS EC2 / ECS | — |
| Servidor web | Nginx Alpine | 1.27 |

---

## 🚀 Correr Localmente con Docker Compose

### Pre-requisitos
- Docker Desktop instalado y corriendo
- Git

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/TU_USUARIO/proyecto-eft.git
cd proyecto-eft

# 2. Configurar variables de entorno
cp .env.example .env
# Editar .env con tus valores

# 3. Levantar todos los servicios
docker-compose up --build

# 4. Verificar que todo está corriendo
docker-compose ps
```

### Acceder a los servicios

| Servicio | URL |
|---|---|
| Frontend | http://localhost |
| API Ventas | http://localhost:8080/swagger-ui.html |
| API Despachos | http://localhost:8081/swagger-ui.html |
| MySQL | localhost:3306 |

### Detener los servicios

```bash
docker-compose down          # Detener
docker-compose down -v       # Detener y eliminar volúmenes
```

---

## 🔄 Pipeline CI/CD

### Flujo del Pipeline

```
git push → main
     │
     ├─► ci-ventas.yml
     │     ├── [1] Checkout
     │     ├── [2] Java 17 setup
     │     ├── [3] mvn clean verify (build + tests)
     │     ├── [4] Docker build & push → DockerHub (latest + sha)
     │     └── [5] SSH deploy → EC2
     │
     ├─► ci-despachos.yml  (mismo flujo)
     │
     └─► ci-frontend.yml
           ├── [1] Checkout
           ├── [2] Node 20 setup
           ├── [3] npm ci + npm run lint + npm run build
           ├── [4] Docker build & push → DockerHub (latest + sha)
           └── [5] SSH deploy → EC2
```

### GitHub Secrets Requeridos

Ir a **Settings → Secrets and variables → Actions** en tu repositorio y configurar:

| Secret | Descripción |
|---|---|
| `DOCKERHUB_USERNAME` | Tu usuario de Docker Hub |
| `DOCKERHUB_TOKEN` | Token de acceso de Docker Hub |
| `DB_ENDPOINT` | Host MySQL (RDS endpoint o IP EC2) |
| `DB_PORT` | Puerto MySQL (`3306`) |
| `DB_NAME` | Nombre de la base de datos |
| `DB_USERNAME` | Usuario MySQL |
| `DB_PASSWORD` | Contraseña MySQL |
| `EC2_HOST` | IP pública de la instancia EC2 |
| `EC2_USERNAME` | Usuario SSH (ej: `ubuntu`) |
| `SSH_PRIVATE_KEY` | Clave privada PEM de EC2 (contenido completo) |

---

## ☁️ Arquitectura AWS

```
AWS Cloud
│
├── VPC (Virtual Private Cloud)
│   ├── Subred Pública
│   │   └── EC2 Instance (Ubuntu 22.04)
│   │       ├── Docker (back-ventas :8080)
│   │       ├── Docker (back-despachos :8081)
│   │       └── Docker (frontend :80)
│   └── Security Group
│       ├── Inbound: 80, 8080, 8081 (0.0.0.0/0)
│       └── Inbound: 22 (SSH, tu IP)
│
└── (Opcional) RDS MySQL — Subred privada
```

### Servicios AWS utilizados

- **EC2**: Instancia t2.micro/t3.small con Ubuntu 22.04 para alojar los contenedores
- **Security Groups**: Control de acceso a puertos (80, 8080, 8081, 22)
- **IAM**: Gestión de permisos mínimos para el pipeline
- **VPC**: Red privada virtual con subred pública

---

## 🐳 Imágenes Docker

Las imágenes están publicadas en Docker Hub:

| Imagen | Tag | Descripción |
|---|---|---|
| `TU_USUARIO/frontend_despacho` | `latest` | Frontend React/Nginx |
| `TU_USUARIO/api_ventas` | `latest` | Backend Ventas |
| `TU_USUARIO/api_despachos` | `latest` | Backend Despachos |

### Buenas prácticas aplicadas

- ✅ **Multistage build**: Imágenes de producción sin herramientas de compilación
- ✅ **Alpine base images**: Imágenes minimalistas y livianas
- ✅ **Non-root user**: Los procesos corren con usuario sin privilegios
- ✅ **Layer caching**: Dependencias copiadas antes del código fuente
- ✅ **JVM container support**: `-XX:+UseContainerSupport` para Java
- ✅ **.dockerignore**: Excluye archivos innecesarios del contexto de build

---

## 📊 Variables de Entorno

| Variable | Descripción | Ejemplo |
|---|---|---|
| `DB_ENDPOINT` | Host de la base de datos | `db` (local) / `xyz.rds.amazonaws.com` (AWS) |
| `DB_PORT` | Puerto MySQL | `3306` |
| `DB_NAME` | Nombre de la BD | `sistemadb` |
| `DB_USERNAME` | Usuario MySQL | `appuser` |
| `DB_PASSWORD` | Contraseña MySQL | `SecurePass123!` |

---

## 🌿 Estrategia de Ramas (Git Flow)

```
main         ← producción (protegida, triggers CI/CD)
  └── develop ← integración
        ├── feature/frontend-xxx
        ├── feature/ventas-xxx
        └── feature/despachos-xxx
```

---

## 👥 Equipo

- **Integrante 1**: [Nombre]
- **Integrante 2**: [Nombre]

---

## 📄 Licencia

Proyecto académico — ISY1101 CITT 2025
