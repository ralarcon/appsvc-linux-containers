
FROM mcr.microsoft.com/appsvc/node:12-lts as main
RUN npm install npm@latest -g
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

EXPOSE 8080
ENTRYPOINT [ "pm2", "serve", "/home/site/wwwroot/dist", "--no-daemon" ]