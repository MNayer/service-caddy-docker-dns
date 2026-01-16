#!/bin/bash

set -e

echo "[+] Get most recent tags."
digest_latest=$(curl -s "https://registry.hub.docker.com/v2/repositories/library/caddy/tags?page_size=100" \
	| jq -r '.results[] | "\(.name) \(.digest)"' \
	| grep 'latest' \
	| cut -d' ' -f2 \
	| cut -d':' -f 2
)

echo "[+] Find the version that's equivalent to the latest tag."
version_latest=$(curl -s "https://registry.hub.docker.com/v2/repositories/library/caddy/tags?page_size=100" \
	| jq -r '.results[] | "\(.name) \(.digest)"' \
	| grep "${digest_latest}" \
	| grep -v "latest" \
	| sort -V \
	| tail -n1 \
	| cut -d' ' -f1
)

echo "[+] Found latest versoin: '${version_latest}'. Create Dockerfile from template."
cat Dockerfile.template | sed "s/CADDYVERSION/${version_latest}/" > Dockerfile
