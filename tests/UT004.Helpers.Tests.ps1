. "$PSScriptRoot/../Helpers/Helpers.ps1"

Describe "Get-PipelineProvider" -Tag "Unit" {
    Context "Repository" {
        It "Should return correct number of providers" {
            $Providers = @(Get-ChildItem -Path "$PSScriptRoot/../Repository" -Directory)
            (Get-PipelineProvider -ProviderType "Repository").Count | Should Be $Providers.Count
        }
    }

    Context "CI" {
        It "Should return correct number of providers" {
            $Providers = @(Get-ChildItem -Path "$PSScriptRoot/../CI" -Directory)
            (Get-PipelineProvider -ProviderType "CI").Count | Should Be $Providers.Count
        }
    }

    Context "CD" {
        It "Should return correct number of providers" {
            $Providers = @(Get-ChildItem -Path "$PSScriptRoot/../CD" -Directory)
            (Get-PipelineProvider -ProviderType "CD").Count | Should Be $Providers.Count
        }
    }
}
