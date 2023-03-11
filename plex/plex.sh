#!/bin/bash

set -xe

export basename=plex

mkdir -p $(pwd)/db
mkdir -p $(pwd)/transcode/temp
mkdir -p $(pwd)/media

docker run \
  --detach=true \
  --hostname=$basename \
  --name=$basename \
  -e TZ="America/Toronto" \
  -e PLEX_CLAIM="my-claim-token" \
  -e PLEX_CLAIM=$MY_PLEX_CLAIM \
  -e PLEX_UID=1000 \
  -e PLEX_GID=1000 \
  -e ADVERTISE_IP="http://0.0.0.0:32400/" \
  -p 32400:32400/tcp \
  -p 8324:8324/tcp \
  -p 32469:32469/tcp \
  -p 1900:1900/udp \
  -p 32410:32410/udp \
  -p 32412:32412/udp \
  -p 32413:32413/udp \
  -p 32414:32414/udp \
  -v $(pwd)/db:/config \
  -v $(pwd)/transcode/temp:/transcode \
  -v $(pwd)/media:/data \
  plexinc/pms-docker
