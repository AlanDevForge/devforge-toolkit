function Get-DevForgeOrphan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository
    )

    $Repository.FindOrphans()
}
