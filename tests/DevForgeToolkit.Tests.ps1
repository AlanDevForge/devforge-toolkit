Describe "DevForgeToolkit" {
    $modulePath = Join-Path $PSScriptRoot "..\DevForgeToolkit.psd1"
    Import-Module $modulePath -Force

    $repo = Open-DevForgeRepository "D:\DevForge\Git\devforge-hq"

    It "loads the module" {
        Get-Command -Module DevForgeToolkit | Should Not BeNullOrEmpty
    }

    It "opens a DevForge repository" {
        $repo | Should Not BeNullOrEmpty
        $repo.Entities.Count | Should BeGreaterThan 0
    }

    It "returns machine entities" {
        Get-DevForgeMachine -Repository $repo | Should Not BeNullOrEmpty
    }

    It "returns product entities" {
        Get-DevForgeProduct -Repository $repo | Should Not BeNullOrEmpty
    }

    It "validates the repository" {
        $result = Test-DevForgeRepository -Repository $repo
        $result.Passed | Should Be $true
    }
}
