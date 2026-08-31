FROM debian:bookworm-slim

LABEL maintainer="grandpaacademy"
LABEL org.opencontainers.image.source="https://github.com/GrandpaAcademy/eggs"
LABEL org.opencontainers.image.description="Zig 0.14 for Pterodactyl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates git jq xz-utils wget && \
    rm -rf /var/lib/apt/lists/*

# Install Zig from official releases (latest stable)
RUN wget -q "https://ziglang.org/download/0.14.0/zig-linux-x86_64-0.14.0.tar.xz" -O /tmp/zig.tar.xz && \
    tar -xf /tmp/zig.tar.xz -C /usr/local && \
    ln -s /usr/local/zig-linux-x86_64-0.14.0/zig /usr/local/bin/zig && \
    rm /tmp/zig.tar.xz

RUN useradd -m -u 998 -s /bin/bash container

USER container
WORKDIR /home/container
