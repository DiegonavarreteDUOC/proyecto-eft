-- ============================================================
-- Script de inicialización de base de datos
-- Se ejecuta automáticamente al crear el contenedor MySQL
-- ============================================================

-- Crear base de datos principal si no existe
CREATE DATABASE IF NOT EXISTS sistemadb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos
USE sistemadb;
