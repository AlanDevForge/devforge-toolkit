class DevForgeEntity {
    [string]$Id
    [string]$Title
    [string]$Type
    [string]$Status
    [datetime]$Created
    [datetime]$Updated
    [string[]]$Tags
    [hashtable]$Relationships
    [string]$Path
    [string]$RelativePath
    [string]$Body
    [hashtable]$Metadata

    DevForgeEntity() {
        $this.Tags = @()
        $this.Relationships = @{}
        $this.Metadata = @{}
    }

    [bool] HasTag([string]$Tag) {
        return $this.Tags -contains $Tag
    }

    [bool] IsActive() {
        return $this.Status -eq "Active"
    }

    [string] ToString() {
        return "$($this.Id) - $($this.Title)"
    }
}
