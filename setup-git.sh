#!/bin/bash
# ============================================================
# Script de configuración inicial del repositorio Git
# ISY1101 — Proyecto EFT
# 
# INSTRUCCIONES:
# 1. Abre Git Bash en la carpeta E:\Estudios\proyecto-eft
# 2. Ejecuta: bash setup-git.sh TU_USUARIO_GITHUB TU_EMAIL
# ============================================================

GITHUB_USER=${1:-"TU_USUARIO_GITHUB"}
GITHUB_EMAIL=${2:-"tu@email.com"}
REPO_NAME="proyecto-eft"

echo "=========================================="
echo " Configurando repositorio Git"
echo " Usuario: $GITHUB_USER"
echo " Email: $GITHUB_EMAIL"
echo "=========================================="

# Configurar identidad Git global
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"

# Inicializar repositorio
git init
git branch -M main

# Primer commit: estructura del proyecto
git add .gitignore .env.example init.sql docker-compose.yml README.md
git commit -m "feat: inicializar proyecto con estructura base

- Agregar docker-compose.yml para orquestación local
- Agregar .env.example con variables de entorno necesarias
- Agregar init.sql para inicialización de BD
- Agregar README.md con documentación completa"

# Segundo commit: Frontend
git add front_despacho/
git commit -m "feat(frontend): agregar React/Vite con Dockerfile multistage

- Dockerfile con build en Node 20 Alpine y runtime en Nginx Alpine
- nginx.conf con soporte SPA y proxy a backends
- .dockerignore para excluir node_modules y dist"

# Tercer commit: Backend Ventas
git add back-ventas/
git commit -m "feat(back-ventas): agregar Spring Boot API REST con Dockerfile

- Dockerfile multistage Maven → JRE 17 Alpine
- Usuario non-root para mayor seguridad
- JVM optimizada para contenedores (UseContainerSupport)"

# Cuarto commit: Backend Despachos
git add back-despachos/
git commit -m "feat(back-despachos): agregar Spring Boot API REST Despachos

- Dockerfile multistage Maven → JRE 17 Alpine
- Puerto 8081 configurado
- Variables de entorno para conexión MySQL"

# Quinto commit: CI/CD Workflows
git add .github/
git commit -m "ci: agregar pipelines GitHub Actions para los 3 componentes

- ci-ventas.yml: build+test Maven → Docker push → EC2 deploy
- ci-despachos.yml: build+test Maven → Docker push → EC2 deploy
- ci-frontend.yml: Vite build → Docker push → EC2 deploy
- Manejo seguro de secretos via GitHub Secrets
- Tags de imagen: latest + sha corto para trazabilidad"

echo ""
echo "=========================================="
echo " Commits creados exitosamente:"
git log --oneline
echo "=========================================="
echo ""
echo "Ahora crea el repositorio en GitHub y ejecuta:"
echo "  git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo "  git push -u origin main"
echo "=========================================="
