function Get-DevForgeProduct {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository,

        [string]$Status
    )

    $items = $Repository.FindByType("Product")

    if ($Status) {
        $items = $items | Where-Object { $_.Status -eq $Status }
    }

    return $items
}
