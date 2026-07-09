function ConvertFrom-DevForgeFrontMatter {
    param(
        [Parameter(Mandatory)]
        [string]$Content
    )

    if ($Content -notmatch "(?s)^---\s*(.*?)\s*---") {
        return $null
    }

    $yaml = $Matches[1]
    $metadata = @{}

    foreach ($line in ($yaml -split "`n")) {
        if ($line -match "^\s*([^:#]+):\s*(.*)$") {
            $metadata[$Matches[1].Trim()] = $Matches[2].Trim()
        }
    }

    return $metadata
}

function Get-DevForgeMarkdownBody {
    param(
        [Parameter(Mandatory)]
        [string]$Content
    )

    return ($Content -replace "(?s)^---\s*.*?\s*---", "").Trim()
}
