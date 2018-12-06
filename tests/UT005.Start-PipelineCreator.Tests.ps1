. "$PSScriptRoot/../Start-PipelineCreator.ps1"
Get-ChildItem -Path "$PSScriptRoot/../Repository/$RepositoryProvider/**/*.ps1" -Recurse | ForEach-Object { . $_ }
Get-ChildItem -Path "$PSScriptRoot/../CI/$RepositoryProvider/**/*.ps1" -Recurse | ForEach-Object { . $_ }
Get-ChildItem -Path "$PSScriptRoot/../CD/$RepositoryProvider/**/*.ps1" -Recurse | ForEach-Object { . $_ }

Describe "Start-PipelineCreator" -Tag "Unit" {

    Context "When Creators return successfully" {
        Mock Start-GitHubRepositoryCreator {return @{}}
        Mock Start-AzureCICreator {return @{}}
        Mock Start-AzureCDCreator {return @{}}

        It "Should pass successfully with valid providers" {
            { Start-PipelineCreator -ProjectName "GoodName" -RepositoryProvider "GitHub" -CIProvider "Azure" -CDProvider "Azure" } | Should not throw
        }

        It "Should fail with a spaced project name" {
            { Start-PipelineCreator -ProjectName "Spaced Name" -RepositoryProvider "GitHub" -CIProvider "Azure" -CDProvider "Azure" } | Should throw
        }

        It "Should call each Creator once" {
            { Start-PipelineCreator -ProjectName "GoodName" -RepositoryProvider "GitHub" -CIProvider "Azure" -CDProvider "Azure" }
            Assert-MockCalled Start-GitHubRepositoryCreator 1
            Assert-MockCalled Start-AzureCICreator 1
            Assert-MockCalled Start-AzureCDCreator 1
        }
    }
}
