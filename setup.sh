#!/bin/bash

set -e

network_name=caddy_net

# docker compose setup
echo "[+] Only continue if you modified the conf/Caddyfile file already. In that case, continue with enter."
read

if [ $(docker network ls | grep ${network_name} | wc -l) -eq 0 ]; then
	docker network create ${network_name}
fi

echo "[+] Install requirements."
sudo apt-get install -y jq curl

echo "[+] Create Dockerfile."
./update_docker.sh

echo "[+] Build image."
./build_container.sh

echo "[*] Setup systemd services"
sudo cp caddy-docker-dns-update.service /etc/systemd/system/
sudo cp caddy-docker-dns-update.timer /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now caddy-docker-dns-update.timer

echo "[+] Start service."
docker compose up -d
