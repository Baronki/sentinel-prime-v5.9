# ============================================================================
# SENTINEL PRIME V5.9 - WINDOWS AUTO-START POWERSHELL SCRIPT
# ============================================================================
# This script starts all Sentinel Prime components on Windows boot
# Add this to Windows Task Scheduler or Startup folder
# ============================================================================

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🛡️  SENTINEL PRIME V5.9 - HEXSTRIKE SECURITY EDITION     ║" -ForegroundColor Cyan
Write-Host "║                    Windows Auto-Start                          ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$ErrorActionPreference = "SilentlyContinue"

# ============================================================================
# 1. WAIT FOR NETWORK
# ============================================================================
Write-Host "[1/5] Waiting for network..." -ForegroundColor Blue
Start-Sleep -Seconds 10
Write-Host "✓ Network ready" -ForegroundColor Green
Write-Host ""

# ============================================================================
# 2. START OLLAMA (if not running)
# ============================================================================
Write-Host "[2/5] Checking Ollama..." -ForegroundColor Blue
$ollamaProcess = Get-Process -Name "ollama" -ErrorAction SilentlyContinue
if (-not $ollamaProcess) {
    Write-Host "  → Starting Ollama..." -ForegroundColor Yellow
    Start-Process "ollama app.exe" -WindowStyle Hidden
    Start-Sleep -Seconds 5
} else {
    Write-Host "  ✓ Ollama already running" -ForegroundColor Green
}
Write-Host ""

# ============================================================================
# 3. START WSL SERVICES
# ============================================================================
Write-Host "[3/5] Starting WSL services..." -ForegroundColor Blue

# Start WSL (if not running)
wsl --status > $null 2>&1
Start-Sleep -Seconds 5

# Run the startup script in WSL
wsl bash -c "chmod +x ~/start-sentinel-all.sh && ~/start-sentinel-all.sh"

Start-Sleep -Seconds 20
Write-Host "✓ WSL services started" -ForegroundColor Green
Write-Host ""

# ============================================================================
# 4. START UNLIMITED AGENTS (OPTIONAL)
# ============================================================================
Write-Host "[4/5] Starting Unlimited Agents..." -ForegroundColor Blue

# Start Gemini CLI in new window
Start-Process wsl -ArgumentList "bash", "-c", "cd ~ && /home/nglert/.npm-global/bin/gemini --yolo --approval-mode yolo --include-directories /" -WindowStyle Normal

Start-Sleep -Seconds 2

# Start Qwen CLI in new window
Start-Process wsl -ArgumentList "bash", "-c", "cd ~ && qwen --yolo --approval-mode yolo --include-directories /" -WindowStyle Normal

Start-Sleep -Seconds 5
Write-Host "✓ Unlimited agents started" -ForegroundColor Green
Write-Host ""

# ============================================================================
# 5. OPEN DASHBOARD
# ============================================================================
Write-Host "[5/5] Opening Dashboard..." -ForegroundColor Blue
Start-Sleep -Seconds 10
Start-Process "http://localhost:8765"
Write-Host "✓ Dashboard opened" -ForegroundColor Green
Write-Host ""

# ============================================================================
# FINAL STATUS
# ============================================================================
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    🎯 STARTUP COMPLETE                         ║" -ForegroundColor Cyan
Write-Host "╠════════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║  Dashboard: http://localhost:8765                              ║" -ForegroundColor White
Write-Host "║  HexStrike: http://localhost:8888                              ║" -ForegroundColor White
Write-Host "║  Ollama: http://localhost:11434                                ║" -ForegroundColor White
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
