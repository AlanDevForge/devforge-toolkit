function Show-DevForgeDashboard {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository
    )

    $stats = $Repository.GetStatistics()

    Write-Host ""
    Write-Host "DevForge Repository Dashboard" -ForegroundColor Cyan
    Write-Host "============================="
    Write-Host ""
    Write-Host "Root:      $($Repository.Root)"
    Write-Host "Entities:  $($stats.Entities)"
    Write-Host "Machines:  $($stats.Machines)"
    Write-Host "Products:  $($stats.Products)"
    Write-Host "Active:    $($stats.Active)"
    Write-Host "Ideas:     $($stats.Ideas)"
    Write-Host ""
}
