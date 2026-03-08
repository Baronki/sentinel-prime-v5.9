#!/bin/bash
# ============================================================================
# SENTINEL PRIME V5.9 - COMPLETE STARTUP SCRIPT
# ============================================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     🛡️  SENTINEL PRIME V5.9 - HEXSTRIKE SECURITY EDITION     ║"
echo "║              Starting All Services - Auto-Start                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Kill existing
pkill -f "backend-v5.9" 2>/dev/null
pkill -f "hexstrike_server" 2>/dev/null
sleep 2

# ============================================================================
# START HEXSTRIKE
# ============================================================================
echo -e "${BLUE}[1/3]${NC} Starting HexStrike Security Server..."

cd ~/hexstrike-ai
nohup python3 hexstrike_server.py > /tmp/hexstrike.log 2>&1 &
HEXSTRIKE_PID=$!
echo "  → HexStrike PID: $HEXSTRIKE_PID"
echo "  → Log: /tmp/hexstrike.log"

# Wait for HexStrike
for i in {1..20}; do
    if curl -s http://localhost:8888/health > /dev/null 2>&1; then
        echo -e "${GREEN}  ✓ HexStrike is ONLINE${NC}"
        break
    fi
    echo -n "."
    sleep 1
done
echo ""

# ============================================================================
# START SENTINEL BACKEND
# ============================================================================
echo -e "${BLUE}[2/3]${NC} Starting Sentinel Prime Backend..."

cd ~
nohup python3 backend-v5.9-hexstrike.py > /tmp/sentinel.log 2>&1 &
SENTINEL_PID=$!
echo "  → Sentinel PID: $SENTINEL_PID"
echo "  → Log: /tmp/sentinel.log"

# Wait for Backend
for i in {1..20}; do
    if curl -s http://localhost:8765/api/status > /dev/null 2>&1; then
        echo -e "${GREEN}  ✓ Sentinel Prime is ONLINE${NC}"
        break
    fi
    echo -n "."
    sleep 1
done
echo ""

# ============================================================================
# FINAL STATUS
# ============================================================================
echo -e "${BLUE}[3/3]${NC} Final Status Check..."
echo ""

# Check services
OLLAMA_STATUS="❌ OFFLINE"
curl -s http://localhost:11434/api/version > /dev/null 2>&1 && OLLAMA_STATUS="✅ ONLINE"

HEXSTRIKE_STATUS="❌ OFFLINE"
curl -s http://localhost:8888/health > /dev/null 2>&1 && HEXSTRIKE_STATUS="✅ ONLINE"

SENTINEL_STATUS="❌ OFFLINE"
curl -s http://localhost:8765/api/status > /dev/null 2>&1 && SENTINEL_STATUS="✅ ONLINE"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    🎯 SERVICE STATUS                           ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo "║  🤖 Ollama:          $OLLAMA_STATUS"
echo "║  🛡️  HexStrike:       $HEXSTRIKE_STATUS"
echo "║  🧠 Sentinel Prime:  $SENTINEL_STATUS"
echo "║  🌐 Dashboard:       http://localhost:8765                    ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo "║  💡 TIPS:                                                      ║"
echo "║  • Open browser: http://localhost:8765                         ║"
echo "║  • Hard refresh: Strg+F5                                       ║"
echo "║  • View logs: cat /tmp/hexstrike.log                           ║"
echo "║  • View logs: cat /tmp/sentinel.log                            ║"
echo "║  • Stop all: pkill -f backend-v5.9; pkill -f hexstrike_server  ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

if [[ "$SENTINEL_STATUS" == "✅ ONLINE" ]]; then
    echo -e "${GREEN}✓ Sentinel Prime V5.9 is READY!${NC}"
    echo ""
    echo "Opening dashboard in browser..."
    explorer.exe http://localhost:8765 2>/dev/null || true
else
    echo -e "${RED}✗ Backend failed to start. Check logs:${NC}"
    echo "  tail -50 /tmp/sentinel.log"
fi

