class DevForgeRepository {
    [string]$Root
    [object]$Config
    [System.Collections.Generic.List[DevForgeEntity]]$Entities
    [System.Collections.Generic.List[DevForgeRelationship]]$Relationships

    DevForgeRepository([string]$Root) {
        $this.Root = (Resolve-Path $Root).Path
        $this.Entities = [System.Collections.Generic.List[DevForgeEntity]]::new()
        $this.Relationships = [System.Collections.Generic.List[DevForgeRelationship]]::new()
    }

    [DevForgeEntity[]] GetEntities() {
        return $this.Entities.ToArray()
    }

    [DevForgeRelationship[]] GetRelationships() {
        return $this.Relationships.ToArray()
    }

    [DevForgeEntity] FindById([string]$Id) {
        return $this.Entities | Where-Object { $_.Id -eq $Id } | Select-Object -First 1
    }

    [DevForgeEntity[]] FindByType([string]$Type) {
        return @($this.Entities | Where-Object { $_.Type -eq $Type })
    }

    [DevForgeEntity[]] FindByStatus([string]$Status) {
        return @($this.Entities | Where-Object { $_.Status -eq $Status })
    }

    [DevForgeEntity[]] FindByTag([string]$Tag) {
        return @($this.Entities | Where-Object { $_.HasTag($Tag) })
    }

    [DevForgeEntity[]] Search([string]$Query) {
        return @(
            $this.Entities | Where-Object {
                $_.Title -like "*$Query*" -or
                $_.Body -like "*$Query*" -or
                ($_.Tags -contains $Query)
            }
        )
    }

    [DevForgeEntity[]] FindDependencies([string]$Id) {
        $targetIds = @($this.Relationships | Where-Object { $_.SourceId -eq $Id } | ForEach-Object { $_.TargetId })
        return @($this.Entities | Where-Object { $targetIds -contains $_.Id })
    }

    [DevForgeEntity[]] FindDependents([string]$Id) {
        $sourceIds = @($this.Relationships | Where-Object { $_.TargetId -eq $Id } | ForEach-Object { $_.SourceId })
        return @($this.Entities | Where-Object { $sourceIds -contains $_.Id })
    }

    [DevForgeEntity[]] FindOrphans() {
        $linkedIds = @()
        $linkedIds += $this.Relationships | ForEach-Object { $_.SourceId }
        $linkedIds += $this.Relationships | ForEach-Object { $_.TargetId }
        $linkedIds = $linkedIds | Select-Object -Unique

        return @($this.Entities | Where-Object { $linkedIds -notcontains $_.Id })
    }

    [hashtable] GetStatistics() {
        return @{
            Entities = $this.Entities.Count
            Relationships = $this.Relationships.Count
            Machines = (@($this.Entities | Where-Object { $_.Type -eq "Machine" })).Count
            Products = (@($this.Entities | Where-Object { $_.Type -eq "Product" })).Count
            Active = (@($this.Entities | Where-Object { $_.Status -eq "Active" })).Count
            Ideas = (@($this.Entities | Where-Object { $_.Status -eq "Idea" })).Count
        }
    }
}
