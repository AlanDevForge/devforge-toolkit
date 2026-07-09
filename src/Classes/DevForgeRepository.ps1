class DevForgeRepository {
    [string]$Root
    [object]$Config
    [System.Collections.Generic.List[DevForgeEntity]]$Entities

    DevForgeRepository([string]$Root) {
        $this.Root = (Resolve-Path $Root).Path
        $this.Entities = [System.Collections.Generic.List[DevForgeEntity]]::new()
    }

    [DevForgeEntity[]] GetEntities() {
        return $this.Entities.ToArray()
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

    [hashtable] GetStatistics() {
        $stats = @{
            Entities = $this.Entities.Count
            Machines = (@($this.Entities | Where-Object { $_.Type -eq "Machine" })).Count
            Products = (@($this.Entities | Where-Object { $_.Type -eq "Product" })).Count
            Active = (@($this.Entities | Where-Object { $_.Status -eq "Active" })).Count
            Ideas = (@($this.Entities | Where-Object { $_.Status -eq "Idea" })).Count
        }

        return $stats
    }
}
