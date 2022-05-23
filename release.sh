#!/usr/bin/env bash
set -euo pipefail

pushd crawl
VERSION=$(git describe)
popd
sudo docker buildx build --push --platform linux/amd64,linux/arm64 -t kelvie/dcss-webtiles:latest .
sudo docker buildx build --push --platform linux/amd64,linux/arm64 -t kelvie/dcss-webtiles:$VERSION .
