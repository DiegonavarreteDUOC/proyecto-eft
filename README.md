# ðŸš€ Sistema de Ventas y Despachos â€” Proyecto Semestral

> **ISY1101 â€” IntroducciÃ³n a Herramientas DevOps**  
> EvaluaciÃ³n Final Transversal (EFT) â€” 2025

[![CI/CD Frontend](https://github.com/DiegonavarreteDUOC/proyecto-eft/actions/workflows/ci-frontend.yml/badge.svg)](https://github.com/DiegonavarreteDUOC/proyecto-eft/actions/workflows/ci-frontend.yml)
[![CI/CD Ventas](https://github.com/DiegonavarreteDUOC/proyecto-eft/actions/workflows/ci-ventas.yml/badge.svg)](https://github.com/DiegonavarreteDUOC/proyecto-eft/actions/workflows/ci-ventas.yml)
[![CI/CD Despachos](https://github.com/DiegonavarreteDUOC/proyecto-eft/actions/workflows/ci-despachos.yml/badge.svg)](https://github.com/DiegonavarreteDUOC/proyecto-eft/actions/workflows/ci-despachos.yml)

---

## ðŸ“ Arquitectura del Sistema

```
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚                          INTERNET                                â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                           â”‚ :80
                    â”Œâ”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”
                    â”‚  FRONTEND   â”‚
                    â”‚ React/Vite  â”‚
                    â”‚ Nginx:80    â”‚
                    â””â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”˜
                           â”‚ app-network
          â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
          â”‚                                 â”‚
   â”Œâ”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”                  â”Œâ”€â”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”
   â”‚  BACK-VENTASâ”‚                  â”‚BACK-DESPACHOSâ”‚
   â”‚ SpringBoot  â”‚                  â”‚ SpringBoot   â”‚
   â”‚  :8080      â”‚                  â”‚  :8081       â”‚
   â””â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”˜                  â””â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”˜
          â”‚                                 â”‚
          â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                  â”Œâ”€â”€â”€â”€â”€â”€â–¼â”€â”€â”€â”€â”€â”€â”
                  â”‚   MySQL DB  â”‚
                  â”‚   :3306     â”‚
                  â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

## ðŸ“ Estructura del Repositorio

```
proyecto-eft/
â”œâ”€â”€ front_despacho/          # Frontend React + Vite + TailwindCSS
â”‚   â”œâ”€â”€ Dockerfile           # Multistage: Nodeâ†’Nginx
â”‚   â”œâ”€â”€ nginx.conf           # ConfiguraciÃ³n Nginx SPA
â”‚   â””â”€â”€ src/
â”œâ”€â”€ back-ventas/             # API REST Ventas (Spring Boot 3.4.4)
â”‚   â”œâ”€â”€ Dockerfile           # Multistage: Mavenâ†’JRE-Alpine
â”‚   â””â”€â”€ src/
â”œâ”€â”€ back-despachos/          # API REST Despachos (Spring Boot 3.4.4)
â”‚   â”œâ”€â”€ Dockerfile           # Multistage: Mavenâ†’JRE-Alpine
â”‚   â””â”€â”€ src/
â”œâ”€â”€ .github/
â”‚   â””â”€â”€ workflows/
â”‚       â”œâ”€â”€ ci-ventas.yml    # Pipeline: buildâ†’testâ†’pushâ†’deploy
â”‚       â”œâ”€â”€ ci-despachos.yml # Pipeline: buildâ†’testâ†’pushâ†’deploy
â”‚       â””â”€â”€ ci-frontend.yml  # Pipeline: buildâ†’pushâ†’deploy
â”œâ”€â”€ docker-compose.yml       # OrquestaciÃ³n local completa
â”œâ”€â”€ init.sql                 # Script inicial de base de datos
â”œâ”€â”€ .env.example             # Plantilla de variables de entorno
â””â”€â”€ README.md
```

---

## ðŸ› ï¸ TecnologÃ­as Utilizadas

| Componente | TecnologÃ­a | VersiÃ³n |
|---|---|---|
| Frontend | React + Vite + TailwindCSS | 18.x / 5.x |
| Backend Ventas | Spring Boot + Java | 3.4.4 / 17 |
| Backend Despachos | Spring Boot + Java | 3.4.4 / 17 |
| Base de Datos | MySQL | 8.0 |
| Contenedores | Docker | 25+ |
| OrquestaciÃ³n local | Docker Compose | 2.x |
| CI/CD | GitHub Actions | â€” |
| Registro de imÃ¡genes | Docker Hub | â€” |
| Nube | AWS EC2 / ECS | â€” |
| Servidor web | Nginx Alpine | 1.27 |

---

## ðŸš€ Correr Localmente con Docker Compose

### Pre-requisitos
- Docker Desktop instalado y corriendo
- Git

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/DiegonavarreteDUOC/proyecto-eft.git
cd proyecto-eft

# 2. Configurar variables de entorno
cp .env.example .env
# Editar .env con tus valores

# 3. Levantar todos los servicios
docker-compose up --build

# 4. Verificar que todo estÃ¡ corriendo
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
docker-compose down -v       # Detener y eliminar volÃºmenes
```

---

## ðŸ”„ Pipeline CI/CD

### Flujo del Pipeline

```
git push â†’ main
     â”‚
     â”œâ”€â–º ci-ventas.yml
     â”‚     â”œâ”€â”€ [1] Checkout
     â”‚     â”œâ”€â”€ [2] Java 17 setup
     â”‚     â”œâ”€â”€ [3] mvn clean verify (build + tests)
     â”‚     â”œâ”€â”€ [4] Docker build & push â†’ DockerHub (latest + sha)
     â”‚     â””â”€â”€ [5] SSH deploy â†’ EC2
     â”‚
     â”œâ”€â–º ci-despachos.yml  (mismo flujo)
     â”‚
     â””â”€â–º ci-frontend.yml
           â”œâ”€â”€ [1] Checkout
           â”œâ”€â”€ [2] Node 20 setup
           â”œâ”€â”€ [3] npm ci + npm run lint + npm run build
           â”œâ”€â”€ [4] Docker build & push â†’ DockerHub (latest + sha)
           â””â”€â”€ [5] SSH deploy â†’ EC2
```

### GitHub Secrets Requeridos

Ir a **Settings â†’ Secrets and variables â†’ Actions** en tu repositorio y configurar:

| Secret | DescripciÃ³n |
|---|---|
| `DOCKERHUB_USERNAME` | Tu usuario de Docker Hub |
| `DOCKERHUB_TOKEN` | Token de acceso de Docker Hub |
| `DB_ENDPOINT` | Host MySQL (RDS endpoint o IP EC2) |
| `DB_PORT` | Puerto MySQL (`3306`) |
| `DB_NAME` | Nombre de la base de datos |
| `DB_USERNAME` | Usuario MySQL |
| `DB_PASSWORD` | ContraseÃ±a MySQL |
| `EC2_HOST` | IP pÃºblica de la instancia EC2 |
| `EC2_USERNAME` | Usuario SSH (ej: `ubuntu`) |
| `SSH_PRIVATE_KEY` | Clave privada PEM de EC2 (contenido completo) |

---

## â˜ï¸ Arquitectura AWS

```
AWS Cloud
â”‚
â”œâ”€â”€ VPC (Virtual Private Cloud)
â”‚   â”œâ”€â”€ Subred PÃºblica
â”‚   â”‚   â””â”€â”€ EC2 Instance (Ubuntu 22.04)
â”‚   â”‚       â”œâ”€â”€ Docker (back-ventas :8080)
â”‚   â”‚       â”œâ”€â”€ Docker (back-despachos :8081)
â”‚   â”‚       â””â”€â”€ Docker (frontend :80)
â”‚   â””â”€â”€ Security Group
â”‚       â”œâ”€â”€ Inbound: 80, 8080, 8081 (0.0.0.0/0)
â”‚       â””â”€â”€ Inbound: 22 (SSH, tu IP)
â”‚
â””â”€â”€ (Opcional) RDS MySQL â€” Subred privada
```

### Servicios AWS utilizados

- **EC2**: Instancia t2.micro/t3.small con Ubuntu 22.04 para alojar los contenedores
- **Security Groups**: Control de acceso a puertos (80, 8080, 8081, 22)
- **IAM**: GestiÃ³n de permisos mÃ­nimos para el pipeline
- **VPC**: Red privada virtual con subred pÃºblica

---

## ðŸ³ ImÃ¡genes Docker

Las imÃ¡genes estÃ¡n publicadas en Docker Hub:

| Imagen | Tag | DescripciÃ³n |
|---|---|---|
| `DiegonavarreteDUOC/frontend_despacho` | `latest` | Frontend React/Nginx |
| `DiegonavarreteDUOC/api_ventas` | `latest` | Backend Ventas |
| `DiegonavarreteDUOC/api_despachos` | `latest` | Backend Despachos |

### Buenas prÃ¡cticas aplicadas

- âœ… **Multistage build**: ImÃ¡genes de producciÃ³n sin herramientas de compilaciÃ³n
- âœ… **Alpine base images**: ImÃ¡genes minimalistas y livianas
- âœ… **Non-root user**: Los procesos corren con usuario sin privilegios
- âœ… **Layer caching**: Dependencias copiadas antes del cÃ³digo fuente
- âœ… **JVM container support**: `-XX:+UseContainerSupport` para Java
- âœ… **.dockerignore**: Excluye archivos innecesarios del contexto de build

---

## ðŸ“Š Variables de Entorno

| Variable | DescripciÃ³n | Ejemplo |
|---|---|---|
| `DB_ENDPOINT` | Host de la base de datos | `db` (local) / `xyz.rds.amazonaws.com` (AWS) |
| `DB_PORT` | Puerto MySQL | `3306` |
| `DB_NAME` | Nombre de la BD | `sistemadb` |
| `DB_USERNAME` | Usuario MySQL | `appuser` |
| `DB_PASSWORD` | ContraseÃ±a MySQL | `SecurePass123!` |

---

## ðŸŒ¿ Estrategia de Ramas (Git Flow)

```
main         â† producciÃ³n (protegida, triggers CI/CD)
  â””â”€â”€ develop â† integraciÃ³n
        â”œâ”€â”€ feature/frontend-xxx
        â”œâ”€â”€ feature/ventas-xxx
        â””â”€â”€ feature/despachos-xxx
```

---

## ðŸ‘¥ Equipo

- **Integrante 1**: [Nombre]
- **Integrante 2**: [Nombre]

---

## ðŸ“„ Licencia

Proyecto acadÃ©mico â€” ISY1101 CITT 2025

