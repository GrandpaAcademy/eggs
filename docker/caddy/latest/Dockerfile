FROM caddy:2-alpine

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="Caddy for Pterodactyl"

RUN adduser -D -u 998 container

USER container
WORKDIR /home/container
