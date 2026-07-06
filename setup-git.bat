@echo off
REM ============================================================
REM Script de configuración inicial del repositorio Git
REM ISY1101 — Proyecto EFT
REM
REM INSTRUCCIONES:
REM 1. Abre CMD o PowerShell en E:\Estudios\proyecto-eft
REM 2. Ejecuta: setup-git.bat TU_USUARIO_GITHUB tu@email.com
REM ============================================================

SET GITHUB_USER=%1
SET GITHUB_EMAIL=%2
SET REPO_NAME=proyecto-eft

IF "%GITHUB_USER%"=="" SET GITHUB_USER=TU_USUARIO_GITHUB
IF "%GITHUB_EMAIL%"=="" SET GITHUB_EMAIL=tu@email.com

echo ==========================================
echo  Configurando repositorio Git
echo  Usuario: %GITHUB_USER%
echo  Email: %GITHUB_EMAIL%
echo ==========================================

REM Configurar identidad Git
git config --global user.name "%GITHUB_USER%"
git config --global user.email "%GITHUB_EMAIL%"

REM Inicializar repositorio
git init
git branch -M main

REM Commit 1: Estructura base
git add .gitignore .env.example init.sql docker-compose.yml README.md
git commit -m "feat: inicializar proyecto con estructura base"

REM Commit 2: Frontend
git add front_despacho/
git commit -m "feat(frontend): agregar React/Vite con Dockerfile multistage"

REM Commit 3: Backend Ventas
git add back-ventas/
git commit -m "feat(back-ventas): agregar Spring Boot API REST con Dockerfile"

REM Commit 4: Backend Despachos
git add back-despachos/
git commit -m "feat(back-despachos): agregar Spring Boot API REST Despachos"

REM Commit 5: CI/CD
git add .github/
git commit -m "ci: agregar pipelines GitHub Actions para los 3 componentes"

echo.
echo ==========================================
echo  Commits creados:
git log --oneline
echo ==========================================
echo.
echo Ahora crea el repositorio en GitHub y ejecuta:
echo   git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
echo   git push -u origin main
echo ==========================================
