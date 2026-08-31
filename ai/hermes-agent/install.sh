#!/bin/bash
# Hermes Agent — Pterodactyl Install Script

set -e

echo "[hermes] Installing Hermes Agent..."

# Create data directory structure
mkdir -p /home/container/{sessions,memories,skills,home,cron,hooks,logs,skins,config}
mkdir -p /home/container/logs/gateways/default

# Make startup script executable
chmod +x /home/container/startup.sh 2>/dev/null || true

# Verify hermes is available
if command -v hermes &> /dev/null; then
    echo "[hermes] hermes CLI found: $(which hermes)"
elif [ -f /opt/hermes/.venv/bin/hermes ]; then
    echo "[hermes] hermes found at /opt/hermes/.venv/bin/hermes"
else
    echo "[hermes] WARNING: hermes binary not found in expected locations"
fi

# Verify s6-overlay
if [ -f /init ]; then
    echo "[hermes] s6-overlay v3 found at /init"
else
    echo "[hermes] WARNING: s6-overlay not found at /init"
fi

# Check Playwright/Chromium
if command -v chromium &> /dev/null || command -v google-chrome &> /dev/null; then
    echo "[hermes] Browser automation available"
else
    echo "[hermes] Note: Browser tools may require Playwright chromium"
fi

echo "[hermes] Installation complete!"
