FROM postgres:15-bookworm

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="PostgreSQL 15 for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl jq && \
    rm -rf /var/lib/apt/lists/*

ENV PGDATA=/home/container/data
ENV PGUSER=postgres

EXPOSE 5432

CMD ["postgres"]
