function Get-DevForgeEntity {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository,

        [string]$Id,
        [string]$Type
    )

    $entities = $Repository.GetEntities()

    if ($Id) {
        $entities = $entities | Where-Object { $_.Id -eq $Id }
    }

    if ($Type) {
        $entities = $entities | Where-Object { $_.Type -eq $Type }
    }

    return $entities
}
