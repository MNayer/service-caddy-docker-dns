#!/bin/bash

set -e

network_name=caddy_net

# docker compose setup
echo "[+] Only continue if you modified the conf/Caddyfile file already. In that case, continue with enter."
read

if [ $(docker network ls | grep ${network_name} | wc -l) -eq 0 ]; then
	docker network create ${network_name}
fi

sudo apt-get install -y jq
./build_container.sh
docker compose up -d
