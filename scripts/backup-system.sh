#!/bin/bash
# ============================================================================
# SENTINEL PRIME - COMPLETE SYSTEM BACKUP SCRIPT
# ============================================================================
# Creates a complete backup of all Sentinel Prime files and configurations
# ============================================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     🛡️  SENTINEL PRIME V5.9 - Complete System Backup          ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Configuration
BACKUP_BASE="/home/nglert/sentinel-backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$BACKUP_BASE/$TIMESTAMP"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo -e "${BLUE}[1/6]${NC} Backing up WSL configuration..."
mkdir -p "$BACKUP_DIR/wsl"

# Sentinel Prime files
cp ~/backend-v5.9-hexstrike.py "$BACKUP_DIR/wsl/" 2>/dev/null
cp ~/start-sentinel-all.sh "$BACKUP_DIR/wsl/" 2>/dev/null
cp ~/update-github-repo.sh "$BACKUP_DIR/wsl/" 2>/dev/null
cp ~/backup-system.sh "$BACKUP_DIR/wsl/" 2>/dev/null

# Sentinel directory
cp -r ~/.sentinel "$BACKUP_DIR/wsl/" 2>/dev/null

# Config files
cp ~/.gemini/settings.json "$BACKUP_DIR/wsl/gemini-settings.json" 2>/dev/null
cp ~/.qwen/settings.json "$BACKUP_DIR/wsl/qwen-settings.json" 2>/dev/null

# Ollama models list
ollama list > "$BACKUP_DIR/wsl/ollama-models.txt" 2>/dev/null

echo -e "${GREEN}  ✓ WSL files backed up${NC}"

echo ""
echo -e "${BLUE}[2/6]${NC} Backing up HexStrike configuration..."
mkdir -p "$BACKUP_DIR/hexstrike"

if [ -d "~/hexstrike-ai" ]; then
    # Copy config files (not the whole directory - too large)
    cp ~/hexstrike-ai/requirements.txt "$BACKUP_DIR/hexstrike/" 2>/dev/null
    cp ~/hexstrike-ai/hexstrike-ai-mcp.json "$BACKUP_DIR/hexstrike/" 2>/dev/null
    cp ~/hexstrike-ai/README.md "$BACKUP_DIR/hexstrike/" 2>/dev/null
    
    # List installed tools
    cd ~/hexstrike-ai && python3 hexstrike_server.py --list-tools > "$BACKUP_DIR/hexstrike/tools-list.txt" 2>/dev/null || true
fi

echo -e "${GREEN}  ✓ HexStrike config backed up${NC}"

echo ""
echo -e "${BLUE}[3/6]${NC} Backing up Windows files..."
mkdir -p "$BACKUP_DIR/windows"

# Copy from Windows
cp /mnt/c/Users/Englert/start-sentinel-all.ps1 "$BACKUP_DIR/windows/" 2>/dev/null
cp /mnt/c/Users/Englert/start-unlimited-agents.ps1 "$BACKUP_DIR/windows/" 2>/dev/null
cp /mnt/c/Users/Englert/backend-v5.9-hexstrike.py "$BACKUP_DIR/windows/" 2>/dev/null
cp /mnt/c/Users/Englert/frontend-v5.9-hexstrike-security.html "$BACKUP_DIR/windows/" 2>/dev/null

# Documentation
cp -r /mnt/c/Users/Englert/docs "$BACKUP_DIR/windows/" 2>/dev/null

echo -e "${GREEN}  ✓ Windows files backed up${NC}"

echo ""
echo -e "${BLUE}[4/6]${NC} Backing up system configuration..."
mkdir -p "$BACKUP_DIR/system"

# Installed packages
dpkg --get-selections > "$BACKUP_DIR/system/package-list.txt" 2>/dev/null
pip3 list > "$BACKUP_DIR/system/pip-packages.txt" 2>/dev/null
npm list -g > "$BACKUP_DIR/system/npm-packages.txt" 2>/dev/null

# Network config
ip addr > "$BACKUP_DIR/system/network-config.txt" 2>/dev/null

# Cron jobs
crontab -l > "$BACKUP_DIR/system/crontab.txt" 2>/dev/null || echo "No crontab" > "$BACKUP_DIR/system/crontab.txt"

echo -e "${GREEN}  ✓ System config backed up${NC}"

echo ""
echo -e "${BLUE}[5/6]${NC} Creating backup manifest..."

cat > "$BACKUP_DIR/MANIFEST.txt" << EOF
SENTINEL PRIME V5.9 - BACKUP MANIFEST
======================================

Backup Date: $(date)
Backup Directory: $BACKUP_DIR
Hostname: $(hostname)
User: $(whoami)

CONTENTS:
---------
ws/                 - WSL configuration files
hexstrike/          - HexStrike configuration
windows/            - Windows startup scripts
system/             - System configuration

FILES:
------
$(find "$BACKUP_DIR" -type f | wc -l) files total
$(du -sh "$BACKUP_DIR" | cut -f1) total size

WSL FILES:
$(ls -la "$BACKUP_DIR/wsl/" 2>/dev/null | wc -l) files

HEXSTRIKE FILES:
$(ls -la "$BACKUP_DIR/hexstrike/" 2>/dev/null | wc -l) files

WINDOWS FILES:
$(ls -la "$BACKUP_DIR/windows/" 2>/dev/null | wc -l) files

SYSTEM FILES:
$(ls -la "$BACKUP_DIR/system/" 2>/dev/null | wc -l) files

RESTORE INSTRUCTIONS:
--------------------
1. Copy backup to new system
2. Run: bash restore-system.sh $BACKUP_DIR
3. Or manually copy files from each directory

EOF

echo -e "${GREEN}  ✓ Manifest created${NC}"

echo ""
echo -e "${BLUE}[6/6]${NC} Compressing backup..."

cd "$BACKUP_BASE"
tar -czf "sentinel-prime-backup-$TIMESTAMP.tar.gz" "$TIMESTAMP/" 2>/dev/null

# Get backup size
BACKUP_SIZE=$(du -h "$BACKUP_DIR" | cut -f1)
COMPRESSED_SIZE=$(du -h "$BACKUP_DIR/../sentinel-prime-backup-$TIMESTAMP.tar.gz" 2>/dev/null | cut -f1)

echo -e "${GREEN}  ✓ Backup compressed${NC}"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    🎯 BACKUP COMPLETE                          ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo -e "║  Backup Location: ${GREEN}$BACKUP_DIR${NC}                            ║"
echo -e "║  Compressed:      ${GREEN}$BACKUP_BASE/sentinel-prime-backup-$TIMESTAMP.tar.gz${NC}║"
echo -e "║  Backup Size:     ${YELLOW}$BACKUP_SIZE${NC}                                           ║"
echo -e "║  Compressed:      ${YELLOW}$COMPRESSED_SIZE${NC}                                           ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo "║  TO RESTORE:                                                   ║"
echo "║  1. Copy backup to new system                                  ║"
echo "║  2. Extract: tar -xzf sentinel-prime-backup-*.tar.gz           ║"
echo "║  3. Run: bash <backup-dir>/restore-system.sh                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Cleanup old backups (keep last 5)
cd "$BACKUP_BASE"
ls -t | tail -n +6 | xargs rm -rf 2>/dev/null
echo -e "${BLUE}ℹ${NC} Old backups cleaned (keeping last 5)"

echo ""
echo -e "${GREEN}✓ Complete system backup finished!${NC}"
