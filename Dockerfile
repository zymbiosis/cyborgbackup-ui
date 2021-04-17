### STAGE 1: Build ###
FROM node:15.14-alpine AS build
RUN apk add git python make g++
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.18.0-alpine
COPY share/nginx.docker /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/dist/ /usr/share/nginx/html