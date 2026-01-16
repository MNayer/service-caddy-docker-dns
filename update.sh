#!/bin/bash

set -e

echo "[+] Update Dockerfile."
./update_docker.sh

echo "[+] Build new image."
./build.sh

echo "[+] Restart service."
docker compose down
docker compose up -d

echo "[+] Done."
