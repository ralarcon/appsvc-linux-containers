
FROM mcr.microsoft.com/appsvc/node:14-lts_20200522.6 as main
RUN npm install npm@latest -g
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

COPY ./startup.blessed.build.sh /opt/startup
RUN chmod +x /opt/startup/startup.blessed.build.sh

EXPOSE 8080 2222
ENTRYPOINT [ "/opt/startup/startup.blessed.source.sh" ]

#FOR NODE 12 ENTRYPOINT [ "pm2", "serve", "/home/site/wwwroot/dist", "--no-daemon" ]
#ENTRYPOINT [ "npx", "serve", "-s", "/home/site/wwwroot/dist" ]
