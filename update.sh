#!/bin/bash

set -e

echo "[+] Update Dockerfile."
./update_docker.sh

echo "[+] Build new image."
./build_container.sh

echo "[+] Restart service."
docker compose down
sleep 30
docker compose up -d

echo "[+] Done."
