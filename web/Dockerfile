# Build du projet Angular avec une image Node
FROM node:alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build-prod

# Copie du projet Angular dans une image Nginx
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/web /usr/share/nginx/html