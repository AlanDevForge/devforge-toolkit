function Export-DevForgeGraph {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository,

        [string]$Path = "exports\devforge-graph.md"
    )

    $outputDir = Split-Path $Path -Parent

    if ($outputDir -and !(Test-Path $outputDir)) {
        New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
    }

    $lines = @()
    $lines += "# DevForge Relationship Graph"
    $lines += ""
    $lines += '```mermaid'
    $lines += "graph TD"

    foreach ($entity in $Repository.GetEntities()) {
        if (!$entity.Id) { continue }

        $safeId = $entity.Id -replace "-", ""
        $label = "$($entity.Title) [$($entity.Id)]"
        $lines += "    $safeId[`"$label`"]"
    }

    foreach ($relationship in $Repository.GetRelationships()) {
        $source = $relationship.SourceId -replace "-", ""
        $target = $relationship.TargetId -replace "-", ""
        $type = $relationship.Type
        $lines += "    $source -->|$type| $target"
    }

    $lines += '```'

    if ($PSCmdlet.ShouldProcess($Path, "Export graph")) {
        Set-Content -Path $Path -Value $lines
        Write-DevForgeSuccess "Exported graph to $Path"
    }
}
