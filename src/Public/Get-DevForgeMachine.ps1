function Get-DevForgeMachine {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository,

        [string]$Status
    )

    $items = $Repository.FindByType("Machine")

    if ($Status) {
        $items = $items | Where-Object { $_.Status -eq $Status }
    }

    return $items
}
