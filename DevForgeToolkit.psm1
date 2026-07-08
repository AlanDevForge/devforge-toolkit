$files = @()

$files += Get-ChildItem -Path "$PSScriptRoot\src\Classes\*.ps1" -ErrorAction SilentlyContinue
$files += Get-ChildItem -Path "$PSScriptRoot\src\Private\*.ps1" -ErrorAction SilentlyContinue
$files += Get-ChildItem -Path "$PSScriptRoot\src\Public\*.ps1" -ErrorAction SilentlyContinue

foreach ($file in $files) {
    . $file.FullName
}

Export-ModuleMember -Function *-DevForge*
