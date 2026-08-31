FROM eclipse-temurin:21-jdk-jammy

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="Java 21 for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates git jq unzip maven && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 998 -s /bin/bash container

USER container
WORKDIR /home/container
