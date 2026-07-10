function Get-DevForgeDependents {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository,

        [Parameter(Mandatory)]
        [string]$Id
    )

    $Repository.FindDependents($Id)
}
