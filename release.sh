#!/usr/bin/env bash
set -euo pipefail

pushd crawl
VERSION=$(git describe)
popd
docker buildx build --push --platform linux/amd64,linux/arm64 -t kelvie/dcss-webtiles:latest .
docker buildx build --push --platform linux/amd64,linux/arm64 -t kelvie/dcss-webtiles:$VERSION .
