#!/bin/bash
# Hermes Agent — Pterodactyl Startup Script

set -e
DATA_DIR="/home/container"
HERMES_BIN="/opt/hermes/.venv/bin/hermes"

# Create directory structure
mkdir -p "${DATA_DIR}"/{sessions,memories,skills,home,cron,hooks,logs,skins,config}
mkdir -p "${DATA_DIR}/logs/gateways/default"

# Write .env from panel environment variables (first run only)
if [ ! -f "${DATA_DIR}/.env" ]; then
cat > "${DATA_DIR}/.env" << EOF
OPENROUTER_API_KEY=${OPENROUTER_API_KEY:-}
ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY:-}
OPENAI_API_KEY=${OPENAI_API_KEY:-}
HERMES_DASHBOARD=${HERMES_DASHBOARD:-1}
HERMES_DASHBOARD_HOST=${HERMES_DASHBOARD_HOST:-0.0.0.0}
HERMES_DASHBOARD_PORT=${HERMES_DASHBOARD_PORT:-9119}
HERMES_DASHBOARD_BASIC_AUTH_USERNAME=${HERMES_DASHBOARD_USERNAME:-admin}
HERMES_DASHBOARD_BASIC_AUTH_PASSWORD=${HERMES_DASHBOARD_PASSWORD:-$(openssl rand -hex 16 2>/dev/null || echo "change-me")}
HERMES_DASHBOARD_BASIC_AUTH_SECRET=${HERMES_DASHBOARD_SECRET:-$(openssl rand -hex 32 2>/dev/null || echo "change-me")}
API_SERVER_ENABLED=${API_SERVER_ENABLED:-true}
API_SERVER_HOST=${API_SERVER_HOST:-0.0.0.0}
API_SERVER_PORT=${API_SERVER_PORT:-8642}
API_SERVER_KEY=${API_SERVER_KEY:-$(openssl rand -hex 32 2>/dev/null || echo "change-me")}
API_SERVER_CORS_ORIGINS=${API_SERVER_CORS_ORIGINS:-*}
EOF
fi

# Write config.yaml (first run only)
if [ ! -f "${DATA_DIR}/config.yaml" ]; then
cat > "${DATA_DIR}/config.yaml" << 'YAML'
tool_loop_guardrails:
  hard_stop_enabled: true
  hard_stop_after:
    exact_failure: 5
    idempotent_no_progress: 5
logging:
  level: INFO
YAML
fi

# Write SOUL.md (first run only)
if [ ! -f "${DATA_DIR}/SOUL.md" ]; then
cat > "${DATA_DIR}/SOUL.md" << 'SOUL'
# SOUL — Hermes Agent
I am Hermes, a self-hosted AI agent running on Zero-Bot. Helpful, knowledgeable, honest, proactive.
SOUL
fi

# Fix ownership for hermes user (UID 10000)
if [ "$(id -u)" = "0" ]; then
  chown -R 10000:10000 "${DATA_DIR}" 2>/dev/null || true
fi

echo "Hermes Agent starting on ports 8642 (API) and 9119 (Dashboard)..."
exec "${HERMES_BIN}" gateway run
