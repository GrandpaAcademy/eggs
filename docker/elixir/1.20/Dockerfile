FROM elixir:1.20-otp-28

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="Elixir 1.20 for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates git jq unzip && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 -s /bin/bash container

USER container
WORKDIR /home/container
