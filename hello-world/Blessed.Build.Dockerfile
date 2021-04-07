
# FROM mcr.microsoft.com/appsvc/node:12-lts as build-stage
# RUN npm install npm@latest -g
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY ./ .
# RUN npm run build

FROM node:latest as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

FROM mcr.microsoft.com/appsvc/node:14-lts_20200522.6 as production-stage
RUN mkdir /app
COPY --from=build-stage /app/dist /home/site/wwwroot

COPY ./startup.blessed.build.sh /opt/startup

RUN chmod +x /opt/startup/startup.blessed.build.sh

EXPOSE 8080 2222
# FOR NODE 12: ENTRYPOINT [ "pm2", "serve", "/home/site/wwwroot", "--no-daemon" ]
ENTRYPOINT [ "/opt/startup/startup.blessed.build.sh" ]