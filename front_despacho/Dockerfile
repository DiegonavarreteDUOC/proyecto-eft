# ==========================================
# Stage 1: Build — Node 20 Alpine
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copiar dependencias primero (aprovechar caché de capas)
COPY package.json package-lock.json ./
RUN npm ci --frozen-lockfile

# Copiar el resto del código fuente
COPY . .

# Construir la aplicación para producción
RUN npm run build

# ==========================================
# Stage 2: Runtime — Nginx Alpine
# ==========================================
FROM nginx:1.27-alpine AS runner

# Eliminar configuración por defecto de Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copiar configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/

# Copiar artefactos construidos desde el stage anterior
COPY --from=builder /app/dist /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx en modo foreground
CMD ["nginx", "-g", "daemon off;"]
