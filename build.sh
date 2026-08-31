#!/bin/bash
# Build all Docker images locally for testing
# Usage: ./build.sh [image_name]

set -e

REGISTRY="ghcr.io"
OWNER="grandpaacademy"
PREFIX="yolks"

build_image() {
    local dir="$1"
    local tag="$2"
    local full_tag="${REGISTRY}/${OWNER}/${PREFIX}_${tag}:latest"
    
    echo "Building ${full_tag}..."
    docker build -t "${full_tag}" "docker/${dir}"
    echo "Built: ${full_tag}"
    echo "---"
}

if [ ! -z "$1" ]; then
    # Build specific image
    case "$1" in
        python3.14) build_image "python/3.14" "python_3.14" ;;
        python3.13) build_image "python/3.13" "python_3.13" ;;
        python3.12) build_image "python/3.12" "python_3.12" ;;
        python3.11) build_image "python/3.11" "python_3.11" ;;
        python3.10) build_image "python/3.10" "python_3.10" ;;
        nodejs24)   build_image "nodejs/24" "nodejs_24" ;;
        nodejs22)   build_image "nodejs/22" "nodejs_22" ;;
        nodejs20)   build_image "nodejs/20" "nodejs_20" ;;
        golang1.24) build_image "golang/1.24" "golang_1.24" ;;
        golang1.23) build_image "golang/1.23" "golang_1.23" ;;
        golang1.22) build_image "golang/1.22" "golang_1.22" ;;
        rust)       build_image "rust/latest" "rust_latest" ;;
        java21)     build_image "java/21" "java_21" ;;
        java17)     build_image "java/17" "java_17" ;;
        caddy)      build_image "caddy/latest" "caddy_latest" ;;
        postgres17) build_image "postgres/17" "postgres_17" ;;
        postgres16) build_image "postgres/16" "postgres_16" ;;
        postgres15) build_image "postgres/15" "postgres_15" ;;
        redis)      build_image "redis/latest" "redis_latest" ;;
        valkey)     build_image "valkey/latest" "valkey_latest" ;;
        nginx)      build_image "nginx/latest" "nginx_latest" ;;
        hermes)     build_image "hermes-agent/latest" "hermes_agent" ;;
        *) echo "Unknown image: $1"; exit 1 ;;
    esac
else
    # Build all
    echo "Building all Docker images..."
    echo ""
    
    build_image "python/3.14" "python_3.14"
    build_image "python/3.13" "python_3.13"
    build_image "python/3.12" "python_3.12"
    build_image "python/3.11" "python_3.11"
    build_image "python/3.10" "python_3.10"
    build_image "nodejs/24" "nodejs_24"
    build_image "nodejs/22" "nodejs_22"
    build_image "nodejs/20" "nodejs_20"
    build_image "golang/1.24" "golang_1.24"
    build_image "golang/1.23" "golang_1.23"
    build_image "golang/1.22" "golang_1.22"
    build_image "rust/latest" "rust_latest"
    build_image "java/21" "java_21"
    build_image "java/17" "java_17"
    build_image "caddy/latest" "caddy_latest"
    build_image "postgres/17" "postgres_17"
    build_image "postgres/16" "postgres_16"
    build_image "postgres/15" "postgres_15"
    build_image "redis/latest" "redis_latest"
    build_image "valkey/latest" "valkey_latest"
    build_image "nginx/latest" "nginx_latest"
    build_image "hermes-agent/latest" "hermes_agent"
    
    echo ""
    echo "All images built successfully!"
    echo ""
    echo "To push to GHCR:"
    echo "  docker push ghcr.io/grandpaacademy/yolks_<tag>:latest"
    echo ""
    echo "Or trigger the GitHub Actions workflow:"
    echo "  gh workflow run docker-publish.yml"
fi
