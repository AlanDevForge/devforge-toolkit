function Open-DevForgeRepository {
<#
.SYNOPSIS
Opens a DevForge HQ repository.

.DESCRIPTION
Loads a DevForge knowledge repository from disk, parses Markdown files with front matter, and returns a DevForgeRepository object containing all discovered entities.

.PARAMETER Path
The path to the DevForge HQ repository.

.EXAMPLE
$repo = Open-DevForgeRepository D:\DevForge\Git\devforge-hq

.EXAMPLE
$repo = Open-DevForgeRepository .\examples\sample-hq
Show-DevForgeDashboard -Repository $repo
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (!(Test-Path $Path)) {
        throw "Repository path not found: $Path"
    }

    $repo = [DevForgeRepository]::new($Path)
    $repo.Config = Get-DevForgeRepositoryConfig $repo.Root

    $markdownFiles = Get-ChildItem $repo.Root -Recurse -Filter "*.md" |
        Where-Object {
            $_.Name -ne "README.md" -and
            $_.FullName -notmatch "\\scripts\\" -and
            $_.FullName -notmatch "\\docs\\"
        }

    foreach ($file in $markdownFiles) {
        $content = Get-Content $file.FullName -Raw
        $metadata = ConvertFrom-DevForgeFrontMatter $content

        if ($null -eq $metadata) {
            continue
        }

        $entity = [DevForgeEntity]::new()
        $entity.Id = $metadata["id"]
        $entity.Title = $metadata["title"]

        if ($metadata.ContainsKey("type")) {
            $entity.Type = $metadata["type"]
        }
        elseif ($metadata.ContainsKey("category")) {
            $entity.Type = $metadata["category"]
        }

        $entity.Status = $metadata["status"]

        if ($metadata.ContainsKey("created") -and $metadata["created"]) {
            $entity.Created = [datetime]$metadata["created"]
        }

        if ($metadata.ContainsKey("updated") -and $metadata["updated"]) {
            $entity.Updated = [datetime]$metadata["updated"]
        }

        $entity.Path = $file.FullName
        $entity.RelativePath = $file.FullName.Replace($repo.Root, "").TrimStart("\")
        $entity.Body = Get-DevForgeMarkdownBody $content
        $entity.Metadata = $metadata

        $repo.Entities.Add($entity)

        if ($entity.Id) {
            $rels = Get-DevForgeRelationshipFromContent -SourceId $entity.Id -Content $content
            foreach ($rel in $rels) {
                $repo.Relationships.Add($rel)
            }
        }
    }

    Write-DevForgeInfo "Loaded $($repo.Entities.Count) entities and $($repo.Relationships.Count) relationships from $($repo.Root)"

    return $repo
}

