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
    [string]$Body

    DevForgeEntity() {
        $this.Tags = @()
        $this.Relationships = @{}
    }
}
