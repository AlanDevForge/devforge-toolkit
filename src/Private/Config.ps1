function Get-DevForgeRepositoryConfig {
    param(
        [Parameter(Mandatory)]
        [string]$Root
    )

    $path = Join-Path $Root "devforge.json"

    if (!(Test-Path $path)) {
        return [pscustomobject]@{
            Brand = "DevForge"
            KnowledgeBasePath = "knowledge-base"
            MachinesPath = "knowledge-base/machines"
            ProductsPath = "products"
        }
    }

    return Get-Content $path -Raw | ConvertFrom-Json
}
