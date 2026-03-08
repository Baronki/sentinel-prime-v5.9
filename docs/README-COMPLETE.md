# 🛡️ SENTINEL PRIME V5.9 - HEXSTRIKE SECURITY EDITION

## 🎯 Ultimate AI Security Command Center

**24/7 Autonomous Security Monitoring • 18 AI Agents • 150+ Security Tools • Full System Access**

---

## 📋 TABLE OF CONTENTS

- [Overview](#overview)
- [Architecture](#architecture)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Offline Installation](#offline-installation)
- [AI Agents](#ai-agents)
- [HexStrike Security](#hexstrike-security)
- [Dashboard](#dashboard)
- [API Reference](#api-reference)
- [Auto-Start](#auto-start)
- [Hardening Tests](#hardening-tests)
- [Windows Access](#windows-access)
- [Troubleshooting](#troubleshooting)

---

## 🚀 OVERVIEW

Sentinel Prime V5.9 is an advanced AI-powered security command center combining:

- **6 Core AI Agents** (Sentinel, Qwen, Gemini, ZeroClaw, Antigravity, HexStrike)
- **12 HexStrike Security Agents** (Specialized cybersecurity AI)
- **150+ Security Tools** (Network scanning, vulnerability assessment, exploit development)
- **24/7 Autonomous Monitoring** (Continuous system protection)
- **Full System Access** (Unlimited mode with YOLO approval)
- **Local + Cloud AI** (Ollama models + Internet-connected CLI agents)
- **Offline Capable** (Complete offline installation package available)

### 🔥 KEY FEATURES

✅ **Real-Time AI Swarm Intelligence** - All agents collaborate on security tasks
✅ **HexStrike Integration** - Professional penetration testing framework
✅ **Unlimited Access Mode** - Full filesystem and command access
✅ **24/7 Security Monitoring** - Continuous threat detection
✅ **Auto-Start System** - Boots automatically after system restart
✅ **Web Dashboard** - Beautiful real-time monitoring interface
✅ **API-First Design** - Full programmatic control
✅ **Evolution Tracking** - System learns and grows with each task
✅ **Skills & Tools Management** - Add new capabilities dynamically
✅ **Windows Integration** - Full access to Windows from WSL

---

## 🏗️ ARCHITECTURE

```
┌─────────────────────────────────────────────────────────────────────┐
│                    SENTINEL PRIME V5.9 - HEXSTRIKE                  │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  🌐 INTERNET-CONNECTED AGENTS (CLI with Unlimited Access):         │
│  ├── QWEN CLI     (--yolo --include-directories /)                 │
│  └── GEMINI CLI   (--yolo --include-directories /)                 │
│                                                                     │
│  🏠 LOKALE OLLAMA MODELLE:                                         │
│  └── Sentinel Prime Enhanced (4.2 GB trained model)                 │
│                                                                     │
│  🛡️ HEXSTRIKE SECURITY (12 Agents via MCP):                       │
│  ├── IntelligentDecisionEngine     ├── TechnologyDetector          │
│  ├── BugBountyWorkflowManager      ├── RateLimitDetector           │
│  ├── CTFWorkflowManager            ├── FailureRecoverySystem       │
│  ├── CVEIntelligenceManager        ├── PerformanceMonitor          │
│  ├── AIExploitGenerator            ├── ParameterOptimizer          │
│  └── VulnerabilityCorrelator       └── GracefulDegradation         │
│                                                                     │
│  🔧 SECURITY TOOLS: 150+                                            │
│                                                                     │
│  📊 BACKEND: FastAPI (Port 8765)                                    │
│  🌐 FRONTEND: PWA Dashboard (http://localhost:8765)                │
│  🛡️ HEXSTRIKE SERVER: Flask (Port 8888)                            │
│  🤖 OLLAMA: Local AI Models (Port 11434)                           │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## ⚡ QUICK START

### START ALL SERVICES

```bash
# Run the startup script
~/start-sentinel-all.sh
```

### OR MANUAL START

```bash
# 1. Start HexStrike Server
cd ~/hexstrike-ai
python3 hexstrike_server.py &

# 2. Start Sentinel Prime Backend
cd ~
python3 backend-v5.9-hexstrike.py &

# 3. Wait for startup
sleep 15

# 4. Open Dashboard
# In browser: http://localhost:8765
```

### VERIFY STATUS

```bash
# Quick health check
python3 quick-check.py

# Full hardening test
python3 hardening-test-v5.9.py
```

---

## 📦 INSTALLATION

### PREREQUISITES

- **Windows 10/11** with WSL2 (Ubuntu 24.04)
- **Python 3.10+** (WSL)
- **Node.js 18+** (Windows & WSL)
- **Ollama** (Windows)
- **Git**

### STEP 1: INSTALL WSL & OLLAMA

```powershell
# Enable WSL
wsl --install -d Ubuntu

# Install Ollama (Windows)
# Download from: https://ollama.com/download
```

### STEP 2: PULL MODELS

```bash
# In WSL terminal
ollama pull sentinel-prime-enhanced:latest
ollama pull tomng/nanbeige4.1:latest
```

### STEP 3: INSTALL HEXSTRIKE

```bash
cd ~
git clone https://github.com/0x4m4/hexstrike-ai.git
cd hexstrike-ai
pip3 install -r requirements.txt --break-system-packages
```

### STEP 4: INSTALL DEPENDENCIES

```bash
# Python packages
pip3 install fastapi uvicorn requests python-multipart --break-system-packages

# Security tools (optional)
sudo apt install -y nmap sqlmap hydra john hashcat
```

### STEP 5: CONFIGURE UNLIMITED ACCESS

```bash
# Create settings directories
mkdir -p ~/.gemini ~/.qwen

# Copy unlimited settings (from package)
cp gemini-unlimited-settings.json ~/.gemini/settings.json
cp qwen-unlimited-settings.json ~/.qwen/settings.json
```

### STEP 6: START SYSTEM

```bash
# Run startup script
~/start-sentinel-all.sh

# Open dashboard
# http://localhost:8765
```

---

## 💾 OFFLINE INSTALLATION

### CREATE OFFLINE PACKAGE

```bash
# Create complete offline installation package
~/create-offline-package.sh
```

This creates: `~/sentinel-offline-package/` containing:
- All Python dependencies (.whl files)
- All scripts and configurations
- Ollama models (if available)
- Complete documentation
- Offline installation script

### INSTALL FROM OFFLINE PACKAGE

```bash
# Copy package to target system
cp -r sentinel-offline-package /home/username/
cd /home/username/sentinel-offline-package

# Run installation (requires root)
sudo ./INSTALL-OFFLINE.sh

# Start system
~/start-sentinel-all.sh
```

### OFFLINE PACKAGE CONTENTS

```
sentinel-offline-package/
├── INSTALL-OFFLINE.sh      # Main installation script
├── python-wheels/          # All Python packages
├── scripts/                # System scripts
├── configs/                # Configuration files
├── docs/                   # Documentation
├── ollama-models/          # Ollama AI models
└── README.md               # Installation guide
```

---

## 🤖 AI AGENTS

### CORE AGENTS (6)

| Agent | Type | Access | Description |
|-------|------|--------|-------------|
| **Sentinel** | Ollama Local | Full | Your trained 4.2GB security AI |
| **Qwen** | CLI Internet | Unlimited | Full filesystem access, YOLO mode |
| **Gemini** | CLI Internet | Unlimited | Full filesystem access, YOLO mode |
| **ZeroClaw** | Binary | Automation | Task automation engine |
| **Antigravity** | Python | Creative | Unconventional problem solving |
| **HexStrike** | Server | Security | 150+ tools coordinator |

### HEXSTRIKE SECURITY AGENTS (12)

| Agent | Function |
|-------|----------|
| **IntelligentDecisionEngine** | Tool selection & optimization |
| **BugBountyWorkflowManager** | Bug bounty automation |
| **CTFWorkflowManager** | CTF challenge solving |
| **CVEIntelligenceManager** | Vulnerability intelligence |
| **AIExploitGenerator** | Automated exploit development |
| **VulnerabilityCorrelator** | Attack chain discovery |
| **TechnologyDetector** | Tech stack identification |
| **RateLimitDetector** | Rate limiting detection |
| **FailureRecoverySystem** | Error handling & recovery |
| **PerformanceMonitor** | System optimization |
| **ParameterOptimizer** | Context-aware optimization |
| **GracefulDegradation** | Fault-tolerant operation |

---

## 🛡️ HEXSTRIKE SECURITY

### AVAILABLE TOOLS (150+)

**Network Security:**
- nmap, masscan, rustscan, amass, subfinder, nuclei, arp-scan, netdiscover

**Web Security:**
- gobuster, feroxbuster, dirsearch, ffuf, nikto, sqlmap, nessus, openvas

**Password Security:**
- hydra, john, hashcat, medusa

**Binary Analysis:**
- gdb, radare2, ghidra, checksec

**Cloud Security:**
- prowler, scout-suite, trivy

**CTF/Forensics:**
- foremost, steghide, exiftool, binwalk

**Windows Security:**
- powershell.exe, windows-defender, firewall-check, event-log

### SECURITY MONITORING

```bash
# Check security status
curl http://localhost:8765/api/hexstrike/security/status

# Run security scan
curl -X POST "http://localhost:8765/api/hexstrike/security/scan?target=localhost"

# Get security report
curl http://localhost:8765/api/hexstrike/security/report
```

---

## 🖥️ DASHBOARD

### ACCESS

```
http://localhost:8765
```

### FEATURES

- **Real-Time Agent Status** - See all 18 agents online/offline
- **Swarm Activity Monitor** - Live view of what each agent is doing
- **Evolution Tracker** - Skills learned, tools mastered, agent growth
- **Individual Agent Chats** - Talk to each agent separately
- **Swarm Chat** - All agents respond together
- **HexStrike Agents** - All 12 security agents with chat
- **Skills & Abilities** - View and add new skills
- **Tools Manager** - View and add new tools
- **Quick Actions** - Security scans, reports

### KEYBOARD SHORTCUTS

- `Strg+F5` - Hard refresh dashboard
- `Enter` - Send message in chat

---

## 📡 API REFERENCE

### BASE URL
```
http://localhost:8765
```

### STATUS ENDPOINTS

```bash
# System status
GET /api/status

# All agents status
GET /api/agents/status

# HexStrike status
GET /api/hexstrike/status
GET /api/hexstrike/agents
GET /api/hexstrike/tools

# Security monitoring
GET /api/hexstrike/security/status
POST /api/hexstrike/security/scan
GET /api/hexstrike/security/report

# Swarm activity
GET /api/swarm/activity
GET /api/swarm/evolution

# Skills & Tools
GET /api/skills/list
POST /api/skills/add
GET /api/tools/list
POST /api/tools/add
```

### CHAT ENDPOINTS

```bash
# Chat with core agent
POST /api/chat/{agent}
Body: {"message": "your message"}

# Chat with HexStrike agent
POST /api/hexstrike/chat/{agent}
Body: {"message": "security task"}

# Swarm chat (all agents)
POST /api/swarm/execute
Body: {"task": "your task"}
```

### EXAMPLES

```bash
# Chat with Sentinel
curl -X POST http://localhost:8765/api/chat/sentinel \
  -H "Content-Type: application/json" \
  -d '{"message": "Are you battle ready?"}'

# Execute swarm task
curl -X POST http://localhost:8765/api/swarm/execute \
  -H "Content-Type: application/json" \
  -d '{"task": "Security scan of localhost"}'

# Add new skill
curl -X POST http://localhost:8765/api/skills/add \
  -H "Content-Type: application/json" \
  -d '{"skill": {"name": "New Skill", "icon": "⭐", "level": 90}}'

# Add new tool
curl -X POST http://localhost:8765/api/tools/add \
  -H "Content-Type: application/json" \
  -d '{"tool": "custom-tool", "category": "🔒 Web Security"}'
```

---

## ⚙️ AUTO-START

### WINDOWS AUTO-START

```powershell
# Run as Administrator
cd C:\Users\Englert
.\setup-windows-autostart.ps1
```

This creates a scheduled task that:
- Runs at every user logon
- Starts Ollama (if not running)
- Starts WSL services
- Opens dashboard in browser

### WSL SYSTEMD SERVICE

```bash
# Install service
sudo cp /etc/systemd/system/sentinel-prime.service
sudo systemctl daemon-reload
sudo systemctl enable sentinel-prime
sudo systemctl start sentinel-prime

# Check status
sudo systemctl status sentinel-prime
```

### MANUAL STARTUP

```bash
# Add to .bashrc
echo '~/start-sentinel-all.sh' >> ~/.bashrc
```

---

## 🧪 HARDENING TESTS

### QUICK CHECK

```bash
# Fast 4-point check (30 seconds)
python3 quick-check.py
```

Tests:
1. Service availability
2. Real tool execution
3. Swarm execution
4. Evolution tracking

### FULL HARDENING TEST

```bash
# Complete test suite (5 minutes)
python3 hardening-test-v5.9.py
```

Tests:
- 25+ comprehensive tests
- Service availability
- API endpoint verification
- Real tool execution
- Swarm coordination
- Skill/tool tracking
- Agent response quality
- Windows access

### TEST REPORT

Reports saved to: `/home/nglert/hardening-report.json`

---

## 🪟 WINDOWS ACCESS

### WSL TO WINDOWS ACCESS

```bash
# Windows C: drive
/mnt/c/Users/Englert/

# Windows PowerShell
powershell.exe "Get-Process"

# Windows Defender
powershell.exe "Start-MpScan -ScanPath C:\Users\Englert"

# Windows Network
powershell.exe "Get-NetTCPConnection"
```

### SWARM WINDOWS TASKS

```
# Example swarm task for Windows security
"Scan Windows system for security issues, check running processes, 
monitor network connections, and protect against threats"
```

The Swarm will:
- Use PowerShell commands
- Check Windows Defender status
- Monitor Windows Firewall
- Analyze Windows Event Logs
- Check Windows Registry

---

## 🐛 TROUBLESHOOTING

### BACKEND NOT STARTING

```bash
# Check logs
cat /tmp/sentinel.log

# Manual start
cd ~
python3 backend-v5.9-hexstrike.py

# Kill and restart
pkill -f backend-v5.9
~/start-sentinel-all.sh
```

### HEXSTRIKE OFFLINE

```bash
# Check logs
cat /tmp/hexstrike.log

# Manual start
cd ~/hexstrike-ai
python3 hexstrike_server.py

# Kill and restart
pkill -f hexstrike_server
~/start-sentinel-all.sh
```

### DASHBOARD NOT LOADING

1. Check backend: `curl http://localhost:8765/api/status`
2. Hard refresh: `Strg+F5`
3. Clear browser cache
4. Restart backend (see above)

### AGENTS TIMEOUT

```bash
# Increase timeout in backend-v5.9-hexstrike.py
# Change timeout=60 to timeout=180

# Restart backend
pkill -f backend-v5.9
~/start-sentinel-all.sh
```

### SKILLS/TOOLS NOT TRACKING

```bash
# Check evolution API
curl http://localhost:8765/api/swarm/evolution

# Run a test task
curl -X POST http://localhost:8765/api/swarm/execute \
  -H "Content-Type: application/json" \
  -d '{"task": "network scan"}'

# Check again
curl http://localhost:8765/api/swarm/evolution
```

---

## 📁 FILE STRUCTURE

```
C:\Users\Englert\
├── backend-v5.9-hexstrike.py          # Main FastAPI backend
├── frontend-v5.9-hexstrike-security.html  # Security dashboard
├── start-sentinel-all.ps1             # Windows startup script
├── start-sentinel-all.sh              # WSL startup script
├── start-unlimited-agents.ps1         # Start CLI agents
├── setup-windows-autostart.ps1        # Auto-start installer
├── update-github-repo.sh              # GitHub backup script
├── backup-system.sh                   # Complete backup script
├── create-offline-package.sh          # Create offline package
├── quick-check.py                     # Quick health check
├── hardening-test-v5.9.py             # Full test suite
└── docs/
    ├── README.md                      # This documentation
    ├── SETUP-SUMMARY.md               # Quick reference
    ├── WINDOWS-ACCESS.md              # Windows integration
    └── sentinel-prime.service         # Systemd service

WSL Home (/home/nglert/):
├── backend-v5.9-hexstrike.py          # Backend (copied)
├── start-sentinel-all.sh              # Startup script
├── quick-check.py                     # Health check
├── hardening-test-v5.9.py             # Test suite
├── create-offline-package.sh          # Package creator
├── sentinel-offline-package/          # Offline install package
├── .sentinel/
│   └── gui/
│       └── index.html                 # Frontend (copied)
├── hexstrike-ai/                      # HexStrike installation
└── .npm-global/bin/
    └── gemini                         # Gemini CLI
```

---

## 🔄 UPDATES & BACKUP

### GITHUB SYNC

```bash
# Run update script
~/update-github-repo.sh

# Or manual
cd ~/sentinel-prime-repo
git add .
git commit -m "Update: $(date)"
git push origin main
```

### LOCAL BACKUP

```bash
# Create complete backup
~/backup-system.sh

# Backups stored in: /home/nglert/sentinel-backups/
```

### OFFLINE PACKAGE UPDATE

```bash
# Recreate offline package with latest changes
~/create-offline-package.sh
```

---

## 📊 STATISTICS

| Metric | Value |
|--------|-------|
| **Total AI Agents** | 18 (6 Core + 12 HexStrike) |
| **Security Tools** | 150+ |
| **API Endpoints** | 25+ |
| **Code Lines** | 900+ (Backend) + 1000+ (Frontend) |
| **Models** | sentinel-prime-enhanced (4.2GB), nanbeige4.1 (4GB) |
| **Ports** | 8765 (Backend), 8888 (HexStrike), 11434 (Ollama) |

---

## 🎯 USAGE EXAMPLES

### 1. SECURITY SCAN

```bash
# Via Dashboard
# Enter "Security scan localhost" → Send to All

# Via API
curl -X POST http://localhost:8765/api/swarm/execute \
  -H "Content-Type: application/json" \
  -d '{"task": "Security scan of localhost"}'
```

### 2. CHAT WITH SENTINEL

```bash
# Via Dashboard
# Type in Sentinel chat: "Are you battle ready?"

# Via API
curl -X POST http://localhost:8765/api/chat/sentinel \
  -H "Content-Type: application/json" \
  -d '{"message": "Are you battle ready?"}'
```

### 3. ADD SKILL

```bash
# Via Dashboard
# Click "+ Add Skill" → Enter details

# Via API
curl -X POST http://localhost:8765/api/skills/add \
  -H "Content-Type: application/json" \
  -d '{"skill": {"name": "Network Analysis", "icon": "🌐", "level": 95}}'
```

### 4. ADD TOOL

```bash
# Via Dashboard
# Click "+ Add Tool" → Enter details

# Via API
curl -X POST http://localhost:8765/api/tools/add \
  -H "Content-Type: application/json" \
  -d '{"tool": "custom-scanner", "category": "🌐 Network"}'
```

---

## ⚠️ SECURITY WARNING

**UNLIMITED MODE ENABLED:**
- Agents have **full filesystem access**
- Can execute **any command** without confirmation
- **No sandbox** restrictions
- **Auto-approve** all actions (YOLO mode)

**Use responsibly!** Only run in trusted environments.

---

## 📞 SUPPORT

- **Dashboard:** http://localhost:8765
- **Logs:** `cat /tmp/sentinel.log`, `cat /tmp/hexstrike.log`
- **Quick Check:** `python3 quick-check.py`
- **Full Tests:** `python3 hardening-test-v5.9.py`

---

## 🎉 VERSION INFO

**Current Version:** V5.9-HexStrike-Security-Edition

**Last Updated:** March 2026

**Build:** Production Ready

**Features:**
- ✅ 18 AI Agents operational
- ✅ 150+ Security tools integrated
- ✅ 24/7 Monitoring active
- ✅ Evolution tracking enabled
- ✅ Skills & Tools management
- ✅ Offline installation package
- ✅ Auto-start configured
- ✅ Hardening test suite
- ✅ Windows integration

---

**🛡️ SENTINEL PRIME - PROTECTING YOUR SYSTEM 24/7 🛡️**
