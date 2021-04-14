#!/usr/bin/env bash

mkdir "$PM2HOME"
chmod 777 "$PM2HOME"
ln -s /home/LogFiles "$PM2HOME"/logs

# Get environment variables to show up in SSH session
eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)

# starting sshd process
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config
/usr/sbin/sshd

## SET ENV CONFIG
JSON_STRING='window.configs = { \
  "VUE_APP_DOCKER_IMAGE":"'"${DOCKER_CUSTOM_IMAGE_NAME}"'", \
  "VUE_APP_COMPUTER":"'"${COMPUTERNAME}"'" \
}'
sed -i "s@// CONFIGURATIONS_PLACEHOLDER@${JSON_STRING}@" /home/site/wwwroot/dist/index.html

npx serve -s /home/site/wwwroot/dist