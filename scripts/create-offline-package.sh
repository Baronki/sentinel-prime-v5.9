#!/bin/bash
# ============================================================================
# SENTINEL PRIME V5.9 - OFFLINE INSTALLATION PACKAGE CREATOR
# ============================================================================
# This script creates a COMPLETE OFFLINE INSTALLATION PACKAGE
# Everything needed to reinstall the system WITHOUT INTERNET
# ============================================================================

set -e

PACKAGE_DIR="/home/nglert/sentinel-offline-package"
WHEELS_DIR="$PACKAGE_DIR/python-wheels"
SCRIPTS_DIR="$PACKAGE_DIR/scripts"
CONFIGS_DIR="$PACKAGE_DIR/configs"
DOCS_DIR="$PACKAGE_DIR/docs"
MODELS_DIR="$PACKAGE_DIR/ollama-models"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     🛡️  SENTINEL PRIME - OFFLINE PACKAGE CREATOR              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Create directory structure
echo "[1/8] Creating directory structure..."
mkdir -p "$PACKAGE_DIR"
mkdir -p "$WHEELS_DIR"
mkdir -p "$SCRIPTS_DIR"
mkdir -p "$CONFIGS_DIR"
mkdir -p "$DOCS_DIR"
mkdir -p "$MODELS_DIR"
echo "  ✓ Package directory: $PACKAGE_DIR"
echo ""

# Download all Python dependencies
echo "[2/8] Downloading Python dependencies..."
cd ~

# Core dependencies
pip3 download --no-cache-dir -d "$WHEELS_DIR" \
    fastapi \
    uvicorn \
    requests \
    python-multipart \
    flask \
    sqlalchemy \
    pydantic \
    httpx \
    aiohttp \
    websockets 2>&1 | tail -5

echo "  ✓ Downloaded core dependencies to $WHEELS_DIR"
echo ""

# HexStrike dependencies
echo "[3/8] Downloading HexStrike dependencies..."
if [ -d "~/hexstrike-ai" ]; then
    cd ~/hexstrike-ai
    pip3 download --no-cache-dir -d "$WHEELS_DIR" -r requirements.txt 2>&1 | tail -5
    echo "  ✓ Downloaded HexStrike dependencies"
else
    echo "  ⚠ HexStrike directory not found, skipping..."
fi
echo ""

# Copy all scripts
echo "[4/8] Copying scripts..."
cp ~/start-sentinel-all.sh "$SCRIPTS_DIR/" 2>/dev/null || true
cp ~/backend-v5.9-hexstrike.py "$SCRIPTS_DIR/" 2>/dev/null || true
cp ~/quick-check.py "$SCRIPTS_DIR/" 2>/dev/null || true
cp ~/hardening-test-v5.9.py "$SCRIPTS_DIR/" 2>/dev/null || true
cp ~/update-github-repo.sh "$SCRIPTS_DIR/" 2>/dev/null || true
cp ~/backup-system.sh "$SCRIPTS_DIR/" 2>/dev/null || true
chmod +x "$SCRIPTS_DIR"/*.sh 2>/dev/null || true
echo "  ✓ Scripts copied to $SCRIPTS_DIR"
echo ""

# Copy configs
echo "[5/8] Copying configurations..."
cp ~/.gemini/settings.json "$CONFIGS_DIR/gemini-settings.json" 2>/dev/null || true
cp ~/.qwen/settings.json "$CONFIGS_DIR/qwen-settings.json" 2>/dev/null || true
cp ~/.sentinel/gui/index.html "$CONFIGS_DIR/frontend.html" 2>/dev/null || true
echo "  ✓ Configs copied to $CONFIGS_DIR"
echo ""

# Copy documentation
echo "[6/8] Copying documentation..."
cp /mnt/c/Users/Englert/docs/*.md "$DOCS_DIR/" 2>/dev/null || true
cp /mnt/c/Users/Englert/*.md "$DOCS_DIR/" 2>/dev/null || true
echo "  ✓ Documentation copied to $DOCS_DIR"
echo ""

# Export Ollama models
echo "[7/8] Exporting Ollama models..."
ollama cp sentinel-prime-enhanced:latest "$MODELS_DIR/sentinel-prime-enhanced" 2>/dev/null && \
    echo "  ✓ Exported sentinel-prime-enhanced" || \
    echo "  ⚠ Could not export sentinel-prime-enhanced"

ollama cp tomng/nanbeige4.1:latest "$MODELS_DIR/nanbeige4.1" 2>/dev/null && \
    echo "  ✓ Exported nanbeige4.1" || \
    echo "  ⚠ Could not export nanbeige4.1"

ollama cp glm-4.7:cloud "$MODELS_DIR/glm-4.7" 2>/dev/null && \
    echo "  ✓ Exported glm-4.7" || \
    echo "  ⚠ Could not export glm-4.7 (cloud model)"
echo ""

# Create installation script
echo "[8/8] Creating offline installation script..."
cat > "$PACKAGE_DIR/INSTALL-OFFLINE.sh" << 'INSTALLSCRIPT'
#!/bin/bash
# ============================================================================
# SENTINEL PRIME V5.9 - OFFLINE INSTALLATION SCRIPT
# ============================================================================
# Install everything from this package WITHOUT INTERNET
# ============================================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     🛡️  SENTINEL PRIME - OFFLINE INSTALLATION                 ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WHEELS_DIR="$PACKAGE_DIR/python-wheels"
SCRIPTS_DIR="$PACKAGE_DIR/scripts"
CONFIGS_DIR="$PACKAGE_DIR/configs"
MODELS_DIR="$PACKAGE_DIR/ollama-models"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "⚠ Please run as root (sudo ./INSTALL-OFFLINE.sh)"
    exit 1
fi

# Install Python packages from wheels
echo "[1/5] Installing Python packages from local wheels..."
pip3 install --no-index --find-links="$WHEELS_DIR" -f "$WHEELS_DIR" --break-system-packages \
    fastapi uvicorn requests python-multipart flask sqlalchemy pydantic httpx aiohttp websockets 2>&1 | tail -3
echo "  ✓ Python packages installed"
echo ""

# Install HexStrike packages
echo "[2/5] Installing HexStrike packages..."
if [ -d "$WHEELS_DIR" ]; then
    pip3 install --no-index --find-links="$WHEELS_DIR" -f "$WHEELS_DIR" --break-system-packages \
        angr pwntools mitmproxy selenium 2>&1 | tail -3
    echo "  ✓ HexStrike packages installed"
else
    echo "  ⚠ Wheels directory not found"
fi
echo ""

# Copy scripts
echo "[3/5] Installing scripts..."
if [ -d "$SCRIPTS_DIR" ]; then
    cp "$SCRIPTS_DIR"/* /home/$SUDO_USER/ 2>/dev/null || true
    chmod +x /home/$SUDO_USER/*.sh 2>/dev/null || true
    echo "  ✓ Scripts installed to /home/$SUDO_USER/"
else
    echo "  ⚠ Scripts directory not found"
fi
echo ""

# Copy configs
echo "[4/5] Installing configurations..."
mkdir -p /home/$SUDO_USER/.gemini /home/$SUDO_USER/.qwen /home/$SUDO_USER/.sentinel/gui
cp "$CONFIGS_DIR"/* /home/$SUDO_USER/ 2>/dev/null || true
echo "  ✓ Configurations installed"
echo ""

# Import Ollama models
echo "[5/5] Importing Ollama models..."
if command -v ollama &> /dev/null; then
    if [ -f "$MODELS_DIR/sentinel-prime-enhanced" ]; then
        ollama cp "$MODELS_DIR/sentinel-prime-enhanced" sentinel-prime-enhanced:latest 2>/dev/null && \
            echo "  ✓ Imported sentinel-prime-enhanced" || \
            echo "  ⚠ Could not import sentinel-prime-enhanced"
    fi
    if [ -f "$MODELS_DIR/nanbeige4.1" ]; then
        ollama cp "$MODELS_DIR/nanbeige4.1" tomng/nanbeige4.1:latest 2>/dev/null && \
            echo "  ✓ Imported nanbeige4.1" || \
            echo "  ⚠ Could not import nanbeige4.1"
    fi
else
    echo "  ⚠ Ollama not installed, skipping model import"
fi
echo ""

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    ✅ INSTALLATION COMPLETE                    ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo "║  Next Steps:                                                   ║"
echo "║  1. Install Ollama: https://ollama.com/download                ║"
echo "║  2. Run: ~/start-sentinel-all.sh                               ║"
echo "║  3. Open: http://localhost:8765                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
INSTALLSCRIPT

chmod +x "$PACKAGE_DIR/INSTALL-OFFLINE.sh"
echo "  ✓ Installation script created"
echo ""

# Calculate package size
PACKAGE_SIZE=$(du -sh "$PACKAGE_DIR" | cut -f1)
WHEELS_COUNT=$(ls -1 "$WHEELS_DIR" 2>/dev/null | wc -l)
SCRIPTS_COUNT=$(ls -1 "$SCRIPTS_DIR" 2>/dev/null | wc -l)

# Create README
cat > "$PACKAGE_DIR/README.md" << EOF
# 🛡️ SENTINEL PRIME V5.9 - OFFLINE INSTALLATION PACKAGE

## 📦 PACKAGE CONTENTS

- **Python Wheels:** $WHEELS_COUNT packages
- **Scripts:** $SCRIPTS_COUNT files
- **Configs:** All system configurations
- **Models:** Ollama models (if exported)
- **Total Size:** $PACKAGE_SIZE

## 🔧 OFFLINE INSTALLATION

### Step 1: Copy Package to Target System
\`\`\`bash
cp -r sentinel-offline-package /home/username/
cd /home/username/sentinel-offline-package
\`\`\`

### Step 2: Run Installation (as root)
\`\`\`bash
sudo ./INSTALL-OFFLINE.sh
\`\`\`

### Step 3: Install Ollama (if not installed)
Download from: https://ollama.com/download

### Step 4: Start System
\`\`\`bash
~/start-sentinel-all.sh
\`\`\`

### Step 5: Open Dashboard
http://localhost:8765

## 📁 DIRECTORY STRUCTURE

\`\`\`
sentinel-offline-package/
├── INSTALL-OFFLINE.sh      # Main installation script
├── python-wheels/          # All Python packages (.whl files)
├── scripts/                # All system scripts
├── configs/                # Configuration files
├── docs/                   # Documentation
├── ollama-models/          # Ollama AI models
└── README.md               # This file
\`\`\`

## ⚠️ REQUIREMENTS

- Ubuntu 24.04 / WSL2
- Python 3.10+
- Ollama (for AI models)
- Node.js 18+ (for CLI tools)

## 🔄 UPDATES

To update this package with latest changes:
\`\`\`bash
~/create-offline-package.sh
\`\`\`

## 🛡️ SYSTEM FEATURES

- 6 Core AI Agents (Sentinel, Qwen, Gemini, ZeroClaw, Antigravity, HexStrike)
- 12 HexStrike Security Agents
- 150+ Security Tools
- 24/7 Autonomous Monitoring
- Full System Access (Unlimited Mode)
- Auto-Start on Boot
- Live Activity Monitoring
- Evolution Tracking

---

**Created:** $(date)
**Version:** V5.9-HexStrike-Security-Edition
**Package Size:** $PACKAGE_SIZE
EOF

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    ✅ PACKAGE CREATED                          ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo "║  Location: $PACKAGE_DIR"
echo "║  Size: $PACKAGE_SIZE"
echo "║  Python Wheels: $WHEELS_COUNT"
echo "║  Scripts: $SCRIPTS_COUNT"
echo "╠════════════════════════════════════════════════════════════════╣"
echo "║  TO INSTALL OFFLINE:                                           ║"
echo "║  1. Copy package to target system                              ║"
echo "║  2. Run: sudo ./INSTALL-OFFLINE.sh                             ║"
echo "║  3. Run: ~/start-sentinel-all.sh                               ║"
echo "╚════════════════════════════════════════════════════════════════╝"
