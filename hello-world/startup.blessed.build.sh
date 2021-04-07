#!/usr/bin/env bash

mkdir "$PM2HOME"
chmod 777 "$PM2HOME"
ln -s /home/LogFiles "$PM2HOME"/logs

# Get environment variables to show up in SSH session
eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)

# starting sshd process
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config
/usr/sbin/sshd

npx serve -s /home/site/wwwroot/