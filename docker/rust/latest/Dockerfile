FROM rust:1-bookworm

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="Rust (latest) for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates git jq unzip pkg-config libssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 998 -s /bin/bash container

USER container
WORKDIR /home/container
