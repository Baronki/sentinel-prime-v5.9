# 🪟 WINDOWS ACCESS FROM WSL - SENTINEL PRIME

## ✅ WSL HAT VOLLEN WINDOWS ZUGRIFF!

### 📁 WINDOWS PFADE IN WSL:

```bash
# Windows C: Laufwerk
/mnt/c/Users/Englert/

# Windows Desktop
/mnt/c/Users/Englert/Desktop/

# Windows Dokumente
/mnt/c/Users/Englert/Dokumente/

# Windows Programme
/mnt/c/Program\ Files/

# Windows Registry (via reg.exe)
reg.exe QUERY HKLM
```

### 🔧 WINDOWS TOOLS VON WSL NUTZEN:

```bash
# Windows PowerShell ausführen
powershell.exe "Get-Process"

# Windows CMD ausführen
cmd.exe /c "dir C:\"

# Windows Programme starten
notepad.exe /mnt/c/Users/Englert/test.txt

# Windows Defender Scan
powershell.exe "Start-MpScan -ScanPath C:\Users\Englert"

# Windows Netzwerk
powershell.exe "Test-NetConnection -ComputerName google.com"
```

### 🛡️ SENTINEL PRIME WINDOWS SECURITY:

**QWEN CLI mit Windows Zugriff:**
```bash
# Windows System scan
powershell.exe "Get-NetTCPConnection | Select-Object LocalPort,RemotePort,State"

# Windows Prozesse überwachen
powershell.exe "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10"

# Windows Firewall
powershell.exe "Get-NetFirewallRule | Where-Object Enabled -Eq True"
```

### 📊 WINDOWS MONITORING VOM SWARM:

**Swarm Task für Windows Security:**
```
Scan Windows system for security issues, check running processes, 
monitor network connections, and protect against threats
```

**Auto-deployed Windows Tools:**
- PowerShell Security Cmdlets
- Windows Defender
- Windows Firewall
- Windows Event Log
- Windows Registry Checker

### ⚠️ WICHTIG:

1. **WSL muss laufen** für Windows Zugriff
2. **PowerShell.exe** muss im PATH sein
3. **Windows Firewall** darf WSL nicht blocken
4. **Admin Rechte** für manche Operationen

### 🚀 WINDOWS INTEGRATION AKTIVIEREN:

**In WSL .bashrc einfügen:**
```bash
# Windows Aliases
alias ps='powershell.exe "Get-Process"'
alias net='powershell.exe "Get-NetTCPConnection"'
alias sec='powershell.exe "Get-MpThreatDetection"'
```

---

**🪟 DER SWARM KANN KOMPLETT WINDOWS ÜBERWACHEN!** 🛡️
