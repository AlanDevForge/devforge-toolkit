param(
    [switch]$Test
)

$ErrorActionPreference = "Stop"

Write-Host "DevForge Toolkit Build" -ForegroundColor Cyan
Write-Host "====================="

Remove-Module DevForgeToolkit -ErrorAction SilentlyContinue
Import-Module .\DevForgeToolkit.psd1 -Force

Write-Host "Module imported successfully." -ForegroundColor Green

Get-Command -Module DevForgeToolkit

if ($Test) {
    if (Get-Module -ListAvailable -Name Pester) {
        Invoke-Pester .\tests
    }
    else {
        Write-Host "Pester is not installed. Skipping tests." -ForegroundColor Yellow
    }
}
