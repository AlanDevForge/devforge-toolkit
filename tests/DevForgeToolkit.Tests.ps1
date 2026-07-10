Describe "DevForgeToolkit" {
    $modulePath = Join-Path $PSScriptRoot "..\DevForgeToolkit.psd1"

    if (-not (Get-Module DevForgeToolkit)) {
        Import-Module $modulePath
    }

    $sampleRepoPath = Join-Path $PSScriptRoot "..\examples\sample-hq"
    $repo = Open-DevForgeRepository $sampleRepoPath

    It "loads the module" {
        Get-Command -Module DevForgeToolkit | Should Not BeNullOrEmpty
    }

    It "opens a sample DevForge repository" {
        $repo | Should Not BeNullOrEmpty
        $repo.Entities.Count | Should Be 2
    }

    It "loads relationships" {
        $repo.Relationships.Count | Should Be 1
    }

    It "returns dependencies" {
        $dependencies = Get-DevForgeDependencies `
            -Repository $repo `
            -Id "PRD-0001"

        $dependencies.Count | Should Be 1
        $dependencies[0].Id | Should Be "MCH-0001"
    }

    It "returns dependents" {
        $dependents = Get-DevForgeDependents `
            -Repository $repo `
            -Id "MCH-0001"

        $dependents.Count | Should Be 1
        $dependents[0].Id | Should Be "PRD-0001"
    }

    It "validates the repository" {
        $result = Test-DevForgeRepository -Repository $repo
        $result.Passed | Should Be $true
    }
}
