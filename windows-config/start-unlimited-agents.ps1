# ============================================================================
# SENTINEL PRIME - UNLIMITED AGENT STARTUP SCRIPT
# ============================================================================
# Start this script to launch Qwen and Gemini with FULL SYSTEM ACCESS
# 
# Usage (PowerShell as Administrator):
#   .\start-unlimited-agents.ps1
#
# Or double-click this file!
# ============================================================================

Write-Host "🚀 Starting Unlimited AI Agents..." -ForegroundColor Green

# ============================================================================
# GEMINI CLI - UNLIMITED MODE
# ============================================================================
Write-Host "🟦 Starting Gemini CLI with unlimited access..." -ForegroundColor Cyan

$geminiArgs = @(
    "--yolo",
    "--approval-mode", "yolo",
    "--include-directories", "/",
    "--model", "gemini-2.5-pro"
)

# Start Gemini in new window
Start-Process wsl -ArgumentList "bash", "-c", "cd ~ && /home/nglert/.npm-global/bin/gemini $($geminiArgs -join ' ')" -WindowStyle Normal

Start-Sleep -Seconds 2

# ============================================================================
# QWEN CODE - UNLIMITED MODE  
# ============================================================================
Write-Host "🟩 Starting Qwen Code with unlimited access..." -ForegroundColor Cyan

$qwenArgs = @(
    "--yolo",
    "--approval-mode", "yolo", 
    "--include-directories", "/",
    "--model", "qwen-max-latest"
)

# Start Qwen in new window
Start-Process wsl -ArgumentList "bash", "-c", "cd ~ && qwen $($qwenArgs -join ' ')" -WindowStyle Normal

Start-Sleep -Seconds 2

# ============================================================================
# STATUS
# ============================================================================
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║         🎯 UNLIMITED AI AGENTS STARTED                       ║" -ForegroundColor Yellow
Write-Host "╠════════════════════════════════════════════════════════════════╣" -ForegroundColor Yellow
Write-Host "║  ⚠️  WARNING: Both agents have FULL SYSTEM ACCESS!            ║" -ForegroundColor Red
Write-Host "║  - Can read/write ANY file                                     ║" -ForegroundColor Red
Write-Host "║  - Can execute ANY command                                     ║" -ForegroundColor Red
Write-Host "║  - No sandbox restrictions                                     ║" -ForegroundColor Red
Write-Host "║  - Auto-approve ALL actions (YOLO mode)                        ║" -ForegroundColor Red
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
Write-Host ""
Write-Host "✅ Agents are running in separate WSL windows!" -ForegroundColor Green
Write-Host ""
Write-Host "To use in Sentinel Prime Dashboard:" -ForegroundColor Cyan
Write-Host "  - Agents will respond with full capabilities" -ForegroundColor White
Write-Host "  - All file system operations allowed" -ForegroundColor White
Write-Host "  - All commands auto-approved" -ForegroundColor White
