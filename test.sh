#!/bin/bash
# Test all eggs - pull images, run them, verify they work
# Usage: ./test.sh [image_name]

set -e

REGISTRY="ghcr.io"
OWNER="grandpaacademy"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASSED=0
FAILED=0
SKIPPED=0

test_image() {
    local name="$1"
    local image="$2"
    local test_cmd="$3"
    local port="${4:-}"
    
    echo -e "${YELLOW}Testing: ${name}${NC}"
    echo "  Image: ${image}"
    
    # Pull
    if ! docker pull "${image}" 2>/dev/null; then
        echo -e "  ${RED}FAIL: Could not pull image${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
    echo "  ✓ Pulled"
    
    # Run test
    if [ -n "$port" ]; then
        # Run with port mapping (for services)
        OUTPUT=$(docker run -d --name "test_${name//\//-}" -p "${port}:${port}" "${image}" 2>&1)
        sleep 3
        
        # Check if container is running
        if docker ps | grep -q "test_${name//\//-}"; then
            echo -e "  ${GREEN}✓ Container running on port ${port}${NC}"
            docker stop "test_${name//\//-}" >/dev/null 2>&1
            docker rm "test_${name//\//-}" >/dev/null 2>&1
            PASSED=$((PASSED + 1))
            return 0
        else
            echo -e "  ${RED}FAIL: Container not running${NC}"
            docker logs "test_${name//\//-}" 2>&1 | tail -5
            docker rm "test_${name//\//-}" >/dev/null 2>&1
            FAILED=$((FAILED + 1))
            return 1
        fi
    else
        # Run with test command (for language images)
        OUTPUT=$(docker run --rm "${image}" ${test_cmd} 2>&1)
        STATUS=$?
        
        if [ $STATUS -eq 0 ]; then
            echo -e "  ${GREEN}✓ Test passed${NC}"
            echo "  Output: $(echo "$OUTPUT" | head -3)"
            PASSED=$((PASSED + 1))
            return 0
        else
            echo -e "  ${RED}FAIL: Test command failed${NC}"
            echo "  Output: $(echo "$OUTPUT" | tail -5)"
            FAILED=$((FAILED + 1))
            return 1
        fi
    fi
}

echo "========================================="
echo "  Grandpa Academy Eggs - Test Suite"
echo "========================================="
echo ""

# Language eggs
echo "--- Language Eggs ---"
test_image "python/3.14" "${REGISTRY}/${OWNER}/yolks_python_3.14:latest" "python3 --version"
test_image "python/3.13" "${REGISTRY}/${OWNER}/yolks_python_3.13:latest" "python3 --version"
test_image "python/3.12" "${REGISTRY}/${OWNER}/yolks_python_3.12:latest" "python3 --version"
test_image "python/3.11" "${REGISTRY}/${OWNER}/yolks_python_3.11:latest" "python3 --version"
test_image "python/3.10" "${REGISTRY}/${OWNER}/yolks_python_3.10:latest" "python3 --version"
echo ""

test_image "nodejs/24" "${REGISTRY}/${OWNER}/yolks_nodejs_24:latest" "node --version && npm --version"
test_image "nodejs/22" "${REGISTRY}/${OWNER}/yolks_nodejs_22:latest" "node --version && npm --version"
test_image "nodejs/20" "${REGISTRY}/${OWNER}/yolks_nodejs_20:latest" "node --version && npm --version"
echo ""

test_image "golang/1.24" "${REGISTRY}/${OWNER}/yolks_golang_1.24:latest" "go version"
test_image "golang/1.23" "${REGISTRY}/${OWNER}/yolks_golang_1.23:latest" "go version"
test_image "golang/1.22" "${REGISTRY}/${OWNER}/yolks_golang_1.22:latest" "go version"
echo ""

test_image "rust/latest" "${REGISTRY}/${OWNER}/yolks_rust_latest:latest" "rustc --version && cargo --version"
echo ""

test_image "java/21" "${REGISTRY}/${OWNER}/yolks_java_21:latest" "java --version"
test_image "java/17" "${REGISTRY}/${OWNER}/yolks_java_17:latest" "java --version"
echo ""

# Software eggs
echo "--- Software Eggs ---"
test_image "caddy" "${REGISTRY}/${OWNER}/yolks_caddy_latest:latest" "caddy version"
echo ""

test_image "nginx" "${REGISTRY}/${OWNER}/yolks_nginx_latest:latest" "nginx -v" "80"
echo ""

test_image "redis" "${REGISTRY}/${OWNER}/yolks_redis_latest:latest" "redis-server --version"
echo ""

test_image "valkey" "${REGISTRY}/${OWNER}/yolks_valkey_latest:latest" "valkey-server --version"
echo ""

test_image "postgres/17" "${REGISTRY}/${OWNER}/yolks_postgres_17:latest" "postgres --version" "5432"
test_image "postgres/16" "${REGISTRY}/${OWNER}/yolks_postgres_16:latest" "postgres --version" "5432"
test_image "postgres/15" "${REGISTRY}/${OWNER}/yolks_postgres_15:latest" "postgres --version" "5432"
echo ""

# AI eggs
echo "--- AI Eggs ---"
test_image "hermes-agent" "${REGISTRY}/${OWNER}/yolks_hermes_agent:latest" "python3 -c 'import hermes; print(\"hermes ok\")'" "8642"
echo ""

# Summary
echo "========================================="
echo "  RESULTS"
echo "========================================="
echo -e "  ${GREEN}Passed: ${PASSED}${NC}"
echo -e "  ${RED}Failed: ${FAILED}${NC}"
echo -e "  ${YELLOW}Skipped: ${SKIPPED}${NC}"
echo "  Total: $((PASSED + FAILED + SKIPPED))"
echo "========================================="

if [ $FAILED -gt 0 ]; then
    exit 1
fi
