FROM node:26-slim

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="Node.js 26 for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates git jq unzip make gcc g++ python3 python3-dev python3-pip libtool && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g tsx

RUN useradd -m -u 998 -s /bin/bash container

USER container
WORKDIR /home/container
