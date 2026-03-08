#!/bin/bash
# ============================================================================
# SENTINEL PRIME V5.9 - GITHUB REPOSITORY UPDATE & SYNC
# ============================================================================
# This script backs up all system files and syncs to GitHub
# Creates local backup AND pushes to GitHub repository
# ============================================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     🛡️  SENTINEL PRIME V5.9 - GitHub Repository Update        ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Configuration
GITHUB_REPO="https://github.com/Baronki/sentinel-prime-v5.9.git"
BACKUP_DIR="/home/nglert/sentinel-backup"
REPO_DIR="/home/nglert/sentinel-prime-repo"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# ============================================================================
# 1. CREATE LOCAL BACKUP
# ============================================================================
echo -e "${BLUE}[1/6]${NC} Creating local backup..."

mkdir -p "$BACKUP_DIR/$TIMESTAMP"

# Copy WSL files
cp -r ~/.sentinel "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null
cp ~/backend-v5.9-hexstrike.py "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null
cp ~/start-sentinel-all.sh "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null
cp ~/quick-check.py "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null
cp ~/hardening-test-v5.9.py "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null
cp ~/create-offline-package.sh "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null

# Copy HexStrike config (not the whole directory - too large)
cp ~/hexstrike-ai/requirements.txt "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null
cp ~/hexstrike-ai/hexstrike-ai-mcp.json "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null

# Copy offline package if exists
cp -r ~/sentinel-offline-package "$BACKUP_DIR/$TIMESTAMP/" 2>/dev/null || true

echo -e "${GREEN}✓ Backup created: $BACKUP_DIR/$TIMESTAMP${NC}"
echo ""

# ============================================================================
# 2. PREPARE GITHUB REPO
# ============================================================================
echo -e "${BLUE}[2/6]${NC} Preparing GitHub repository..."

if [ ! -d "$REPO_DIR" ]; then
    echo "  → Cloning repository..."
    git clone "$GITHUB_REPO" "$REPO_DIR" 2>/dev/null || {
        echo -e "${YELLOW}  ⚠ Could not clone repository. Creating new...${NC}"
        mkdir -p "$REPO_DIR"
        cd "$REPO_DIR"
        git init
        git remote add origin "$GITHUB_REPO"
    }
fi

cd "$REPO_DIR"

# Create directory structure
mkdir -p backend frontend docs scripts wsl-config windows-config offline-package

echo -e "${GREEN}✓ Repository prepared${NC}"
echo ""

# ============================================================================
# 3. COPY FILES TO REPO
# ============================================================================
echo -e "${BLUE}[3/6]${NC} Copying files to repository..."

# Backend
cp ~/backend-v5.9-hexstrike.py "$REPO_DIR/backend/" 2>/dev/null && echo "  → Backend copied"

# Frontend
cp ~/.sentinel/gui/index.html "$REPO_DIR/frontend/" 2>/dev/null && echo "  → Frontend copied"

# Scripts
cp ~/start-sentinel-all.sh "$REPO_DIR/scripts/" 2>/dev/null && echo "  → Startup script copied"
cp ~/quick-check.py "$REPO_DIR/scripts/" 2>/dev/null && echo "  → Quick check copied"
cp ~/hardening-test-v5.9.py "$REPO_DIR/scripts/" 2>/dev/null && echo "  → Hardening test copied"
cp ~/create-offline-package.sh "$REPO_DIR/scripts/" 2>/dev/null && echo "  → Package creator copied"
cp ~/update-github-repo.sh "$REPO_DIR/scripts/" 2>/dev/null && echo "  → GitHub update copied"
cp ~/backup-system.sh "$REPO_DIR/scripts/" 2>/dev/null && echo "  → Backup script copied"

# Windows configs
cp /mnt/c/Users/Englert/start-sentinel-all.ps1 "$REPO_DIR/windows-config/" 2>/dev/null && echo "  → Windows startup copied"
cp /mnt/c/Users/Englert/start-unlimited-agents.ps1 "$REPO_DIR/windows-config/" 2>/dev/null && echo "  → Unlimited agents script copied"
cp /mnt/c/Users/Englert/setup-windows-autostart.ps1 "$REPO_DIR/windows-config/" 2>/dev/null && echo "  → Windows auto-start copied"

# Documentation
cp /mnt/c/Users/Englert/docs/*.md "$REPO_DIR/docs/" 2>/dev/null && echo "  → Documentation copied"
cp /mnt/c/Users/Englert/docs/sentinel-prime.service "$REPO_DIR/wsl-config/" 2>/dev/null && echo "  → Systemd service copied"

# Create main README if not exists or update it
cp /mnt/c/Users/Englert/docs/README-COMPLETE.md "$REPO_DIR/README.md" 2>/dev/null && echo "  → Main README updated"

echo -e "${GREEN}✓ Files copied${NC}"
echo ""

# ============================================================================
# 4. GIT COMMIT & PUSH
# ============================================================================
echo -e "${BLUE}[4/6]${NC} Committing changes to GitHub..."

cd "$REPO_DIR"

# Configure git (if not already)
git config user.email "sentinel-prime@local" 2>/dev/null
git config user.name "Sentinel Prime" 2>/dev/null

# Add all files
git add -A

# Check if there are changes
if git diff --staged --quiet; then
    echo "  → No changes to commit"
else
    # Commit
    git commit -m "Update $(date '+%Y-%m-%d %H:%M') - Auto-backup
    
Updated components:
- Backend V5.9 HexStrike
- Frontend Security Dashboard
- Scripts & Tools
- Documentation
- Offline Package

Generated by: update-github-repo.sh"
    
    # Push
    echo "  → Pushing to GitHub..."
    git push origin main 2>&1 || {
        echo -e "${YELLOW}  ⚠ Push failed. Please check credentials.${NC}"
        echo "  → You can manually push later with: cd $REPO_DIR && git push"
    }
fi

echo -e "${GREEN}✓ Git operations complete${NC}"
echo ""

# ============================================================================
# 5. CREATE OFFLINE PACKAGE (Optional)
# ============================================================================
echo -e "${BLUE}[5/6]${NC} Offline Package..."

if [ -d "~/sentinel-offline-package" ]; then
    # Copy existing package
    cp -r ~/sentinel-offline-package "$REPO_DIR/offline-package/" 2>/dev/null && \
        echo "  ✓ Offline package copied to repo" || \
        echo "  ⚠ Could not copy offline package"
else
    echo "  → Creating new offline package..."
    ~/create-offline-package.sh 2>&1 | tail -5
    cp -r ~/sentinel-offline-package "$REPO_DIR/offline-package/" 2>/dev/null && \
        echo "  ✓ Offline package created and copied" || \
        echo "  ⚠ Could not create offline package"
fi

echo ""

# ============================================================================
# 6. SUMMARY
# ============================================================================
echo -e "${BLUE}[6/6]${NC} Summary"
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    🎯 UPDATE COMPLETE                          ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo -e "║  Local Backup:   ${GREEN}$BACKUP_DIR/$TIMESTAMP${NC}                  ║"
echo -e "║  GitHub Repo:    ${GREEN}$REPO_DIR${NC}                             ║"
echo "║                                                                ║"
echo "║  Files Backed Up:                                              ║"
echo "║  • Backend (FastAPI)                                           ║"
echo "║  • Frontend (Dashboard)                                        ║"
echo "║  • Startup Scripts (WSL + Windows)                             ║"
echo "║  • Test Suites (Quick Check, Hardening)                        ║"
echo "║  • Documentation (Complete README)                             ║"
echo "║  • Configuration Files                                         ║"
echo "║  • Offline Package (if created)                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo -e "${GREEN}✓ GitHub repository updated!${NC}"
echo ""
echo "To view your repository:"
echo "  cd $REPO_DIR"
echo "  git log --oneline -5"
echo ""
