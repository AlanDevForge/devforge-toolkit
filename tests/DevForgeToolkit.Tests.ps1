Describe "DevForgeToolkit" {
    $modulePath = Join-Path $PSScriptRoot "..\DevForgeToolkit.psd1"
    Import-Module $modulePath -Force

    $sampleRepoPath = Join-Path $PSScriptRoot "..\examples\sample-hq"
    $repo = Open-DevForgeRepository $sampleRepoPath

    It "loads the module" {
        Get-Command -Module DevForgeToolkit | Should Not BeNullOrEmpty
    }

    It "opens a sample DevForge repository" {
        $repo | Should Not BeNullOrEmpty
        $repo.Entities.Count | Should Be 2
    }

    It "returns machine entities" {
        $machines = Get-DevForgeMachine -Repository $repo
        $machines.Count | Should Be 1
    }

    It "returns product entities" {
        $products = Get-DevForgeProduct -Repository $repo
        $products.Count | Should Be 1
    }

    It "validates the repository" {
        $result = Test-DevForgeRepository -Repository $repo
        $result.Passed | Should Be $true
    }
}
