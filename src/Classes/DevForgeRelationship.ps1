class DevForgeRelationship {
    [string]$SourceId
    [string]$TargetId
    [string]$Type

    DevForgeRelationship([string]$SourceId, [string]$TargetId, [string]$Type) {
        $this.SourceId = $SourceId
        $this.TargetId = $TargetId
        $this.Type = $Type
    }

    [string] ToString() {
        return "$($this.SourceId) --$($this.Type)--> $($this.TargetId)"
    }
}
