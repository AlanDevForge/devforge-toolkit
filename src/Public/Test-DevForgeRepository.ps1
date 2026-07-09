function Test-DevForgeRepository {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [DevForgeRepository]$Repository
    )

    $errors = 0
    $ids = @{}

    foreach ($entity in $Repository.GetEntities()) {
        if (!$entity.Id) {
            Write-DevForgeError "Missing ID: $($entity.RelativePath)"
            $errors++
            continue
        }

        if ($ids.ContainsKey($entity.Id)) {
            Write-DevForgeError "Duplicate ID: $($entity.Id)"
            $errors++
        }
        else {
            $ids[$entity.Id] = $entity.RelativePath
        }
    }

    if ($errors -eq 0) {
        Write-DevForgeSuccess "Repository validation passed."
    }
    else {
        Write-DevForgeError "Repository validation failed with $errors error(s)."
    }

    [pscustomobject]@{
        EntityCount = $Repository.Entities.Count
        UniqueIds = $ids.Count
        Errors = $errors
        Passed = ($errors -eq 0)
    }
}
