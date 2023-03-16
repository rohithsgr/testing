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
