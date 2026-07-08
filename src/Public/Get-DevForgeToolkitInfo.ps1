function Get-DevForgeToolkitInfo {
    [CmdletBinding()]
    param()

    [pscustomobject]@{
        Name = "DevForgeToolkit"
        Version = "0.1.0"
        Purpose = "Manage DevForge HQ knowledge repositories"
    }
}
