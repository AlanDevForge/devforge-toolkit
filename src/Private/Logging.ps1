function Write-DevForgeLog {
    param(
        [string]$Level,
        [string]$Message,
        [ConsoleColor]$Color = "White"
    )

    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timestamp] $Level`t$Message" -ForegroundColor $Color
}

function Write-DevForgeInfo {
    param([string]$Message)
    Write-DevForgeLog "INFO" $Message "Cyan"
}

function Write-DevForgeSuccess {
    param([string]$Message)
    Write-DevForgeLog "SUCCESS" $Message "Green"
}

function Write-DevForgeWarning {
    param([string]$Message)
    Write-DevForgeLog "WARN" $Message "Yellow"
}

function Write-DevForgeError {
    param([string]$Message)
    Write-DevForgeLog "ERROR" $Message "Red"
}
