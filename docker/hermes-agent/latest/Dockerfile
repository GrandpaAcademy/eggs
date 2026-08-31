FROM python:3.12-slim-bookworm

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="Hermes Agent for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates git jq wget gnupg software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Install hermes-agent via pip
RUN pip install --no-cache-dir hermes-agent

# Create s6-overlay compatible structure
RUN mkdir -p /etc/s6-overlay/s6-rc.d/ /etc/s6-overlay/scripts/

# Create container user
RUN useradd -m -u 998 -s /bin/bash container && \
    mkdir -p /home/container/{sessions,memories,skills,home,cron,hooks,logs,skins,config} && \
    mkdir -p /home/container/logs/gateways/default && \
    chown -R 998:998 /home/container

USER container
WORKDIR /home/container

EXPOSE 8642 9119

CMD ["/opt/hermes/.venv/bin/hermes", "gateway", "run"]
