# ============================================================================
# SENTINEL PRIME V5.9 - WINDOWS TASK SCHEDULER AUTO-START SETUP
# ============================================================================
# Run this script as Administrator to add Sentinel Prime to Windows startup
# ============================================================================

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🛡️  SENTINEL PRIME V5.9 - Windows Auto-Start Setup        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$taskName = "Sentinel Prime V5.9 Auto-Start"
$scriptPath = "C:\Users\Englert\start-sentinel-all.ps1"
$logPath = "C:\Users\Englert\sentinel-startup.log"

# Check if script exists
if (-not (Test-Path $scriptPath)) {
    Write-Host "✗ Script not found: $scriptPath" -ForegroundColor Red
    Write-Host "  Please ensure start-sentinel-all.ps1 exists"
    exit 1
}

# ============================================================================
# 1. REMOVE EXISTING TASK
# ============================================================================
Write-Host "[1/4] Removing existing task (if any)..." -ForegroundColor Blue
Unregister-ScheduledTask -TaskName $taskName -Confirm:$false 2>$null
Write-Host "✓ Existing task removed" -ForegroundColor Green
Write-Host ""

# ============================================================================
# 2. CREATE TRIGGER (At logon)
# ============================================================================
Write-Host "[2/4] Creating logon trigger..." -ForegroundColor Blue
$trigger = New-ScheduledTaskTrigger -AtLogon
Write-Host "✓ Trigger created (runs at user logon)" -ForegroundColor Green
Write-Host ""

# ============================================================================
# 3. CREATE ACTION
# ============================================================================
Write-Host "[3/4] Creating action..." -ForegroundColor Blue

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" `
    -WorkingDirectory "C:\Users\Englert"

Write-Host "✓ Action created" -ForegroundColor Green
Write-Host ""

# ============================================================================
# 4. REGISTER TASK
# ============================================================================
Write-Host "[4/4] Registering task..." -ForegroundColor Blue

$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable `
    -WakeToRun

$principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType S4U -RunLevel Highest

Register-ScheduledTask -TaskName $taskName `
    -Trigger $trigger `
    -Action $action `
    -Settings $settings `
    -Principal $principal `
    -Description "Automatically starts Sentinel Prime V5.9 - HexStrike Security Edition at user logon"

Write-Host "✓ Task registered successfully" -ForegroundColor Green
Write-Host ""

# ============================================================================
# SUMMARY
# ============================================================================
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    🎯 SETUP COMPLETE                           ║" -ForegroundColor Cyan
Write-Host "╠════════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║  Task Name:     $taskName" -ForegroundColor White
Write-Host "║  Script:        $scriptPath" -ForegroundColor White
Write-Host "║  Trigger:       At user logon" -ForegroundColor White
Write-Host "║  Run Level:     Highest (Administrator)" -ForegroundColor White
Write-Host "╠════════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║  TO TEST:                                                      ║" -ForegroundColor White
Write-Host "║  Start-ScheduledTask -TaskName `"$taskName`"" -ForegroundColor White
Write-Host "║                                                                ║" -ForegroundColor White
Write-Host "║  TO REMOVE:                                                    ║" -ForegroundColor White
Write-Host "║  Unregister-ScheduledTask -TaskName `"$taskName`"" -ForegroundColor White
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "✓ Sentinel Prime will now start automatically at logon!" -ForegroundColor Green
Write-Host ""
