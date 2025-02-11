# Usar una imagen oficial de Node.js como base
FROM node:16 AS build

# Crear un directorio para el proyecto
WORKDIR /app

# Copiar el package.json y el package-lock.json
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar todo el código fuente al contenedor
COPY . .

# Construir la aplicación React para producción
RUN npm run build

# Usar una imagen ligera de Nginx para servir el build
FROM nginx:alpine

# Copiar el build de React a la carpeta donde Nginx lo servirá
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto en el que Nginx estará escuchando
EXPOSE 80

# Comando para ejecutar Nginx en el contenedor
CMD ["nginx", "-g", "daemon off;"]

