#!/bin/bash
cat <<EOT >Dockerfile
FROM node:16-alpine as build
WORKDIR /rohithbuildapp
COPY package*.json /rohithbuildapp/
RUN npm install
COPY . .
RUN npm run build
FROM nginx:latest
COPY --from=build /rohithbuildapp/build/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOT

echo "Completed creating docker file. Below are its contents"

cat Dockerfile


echo "Now we will create an image using this docker file with when function using jenkins "

docker build -t rohithsgr/dev:${BUILD_NUMBER} .
