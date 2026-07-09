function Get-DevForgeToolkitInfo {
    [CmdletBinding()]
    param()

    [pscustomobject]@{
        Name = "DevForgeToolkit"
        Version = "0.2.0"
        Purpose = "Manage DevForge HQ knowledge repositories"
    }
}
