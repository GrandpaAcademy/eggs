FROM python:3.13-slim-bookworm

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="Python 3.13 for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates git jq unzip build-essential libtool && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 998 -s /bin/bash container

USER container
WORKDIR /home/container
