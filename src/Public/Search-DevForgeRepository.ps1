function Search-DevForgeRepository {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository,

        [Parameter(Mandatory)]
        [string]$Query
    )

    $Repository.Search($Query)
}
