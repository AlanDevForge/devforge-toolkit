function Get-DevForgeDependencies {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository,

        [Parameter(Mandatory)]
        [string]$Id
    )

    $Repository.FindDependencies($Id)
}
