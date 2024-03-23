#!/bin/bash
apt-get update && apt-get upgrade -y
systemctl reload postfix
apt-get install curl sudo git vim net-tools -y
curl -sSL https://install.pi-hole.net | sudo PIHOLE_SKIP_OS_CHECK=true bash
# Cloudflared Install
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo apt-get install ./cloudflared-linux-amd64.deb
cloudflared -v
sudo useradd -s /usr/sbin/nologin -r -M cloudflared
# commented out because this can't be done on script for whatever reason
# https://docs.pi-hole.net/guides/dns/cloudflared/?h=cloud
# echo CLOUDFLARED_OPTS=--port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query > /etc/default/cloudflared
# sudo chown cloudflared:cloudflared /etc/default/cloudflared
# sudo chown cloudflared:cloudflared /usr/local/bin/cloudflared
# source /etc/default/cloudflared
# cat > /etc/systemd/system/cloudflared.service << EOF
# [Unit]
# Description=cloudflared DNS over HTTPS proxy
# After=syslog.target network-online.target

# [Service]
# Type=simple
# User=cloudflared
# EnvironmentFile=/etc/default/cloudflared
# ExecStart=/usr/local/bin/cloudflared proxy-dns --port 5053 $CLOUDFLARED_OPTS
# Restart=on-failure
# RestartSec=10
# KillMode=process

# [Install]
# WantedBy=multi-user.target
# EOF
# sudo systemctl enable cloudflared
# sudo systemctl start cloudflared
# sudo systemctl restart cloudflared
# apt remove curl git net-tools -y