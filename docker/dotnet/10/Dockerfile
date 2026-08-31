FROM mcr.microsoft.com/dotnet/sdk:10.0

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description=".NET SDK 10.0 for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates git jq unzip && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 998 -s /bin/bash container

USER container
WORKDIR /home/container
