#!/usr/bin/env bash
set -euo pipefail

pushd crawl
VERSION=$(git describe)
popd
docker-compose build
docker tag kelvie/dcss-webtiles:latest kelvie/dcss-webtiles:$VERSION
docker push kelvie/dcss-webtiles:latest
docker push kelvie/dcss-webtiles:$VERSION
