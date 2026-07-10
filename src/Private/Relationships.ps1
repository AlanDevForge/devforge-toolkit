function Get-DevForgeRelationshipFromContent {
    param(
        [Parameter(Mandatory)]
        [string]$SourceId,

        [Parameter(Mandatory)]
        [string]$Content
    )

    $relationships = @()

    if ($Content -notmatch "(?s)^---\s*(.*?)\s*---") {
        return $relationships
    }

    $frontMatter = $Matches[1]
    $insideRelationships = $false
    $currentType = $null

    foreach ($line in ($frontMatter -split "\r?\n")) {
        if ($line -match "^relationships:\s*$") {
            $insideRelationships = $true
            $currentType = $null
            continue
        }

        if (-not $insideRelationships) {
            continue
        }

        # A new top-level property means the relationship block has ended.
        if ($line -match "^\S") {
            break
        }

        if ($line -match "^\s{2}([a-zA-Z0-9_-]+):\s*(?:\[\])?\s*$") {
            $currentType = $Matches[1]
            continue
        }

        if (
            $currentType -and
            $line -match "^\s{4}-\s*([A-Z]{3}-\d{4})\s*$"
        ) {
            $relationships += [DevForgeRelationship]::new(
                $SourceId,
                $Matches[1],
                $currentType
            )
        }
    }

    return $relationships
}
