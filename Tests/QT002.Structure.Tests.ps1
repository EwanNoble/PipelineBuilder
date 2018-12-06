Describe "Code structure tests" -Tag "Structure" {

    Context "Repository Providers have correct structure" {

        $RepositoryProviders = Get-ChildItem -Path "$PSScriptRoot/../Repository" -Directory

        foreach ($Provider in $RepositoryProviders) {
            It "Should have a correctly named Creator script" {
                Get-ChildItem -Path "$($Provider.FullName)/Start-$($Provider.Name)RepositoryCreator.ps1"
            }
        }
    }

    Context "CI Providers have correct structure" {

        $CIProviders = Get-ChildItem -Path "$PSScriptRoot/../CI" -Directory

        foreach ($Provider in $CIProviders) {
            It "Should have a correctly named Creator script" {
                Get-ChildItem -Path "$($Provider.FullName)/Start-$($Provider.Name)CICreator.ps1"
            }
        }
    }

    Context "CD Providers have correct structure" {

        $CDProviders = Get-ChildItem -Path "$PSScriptRoot/../CD" -Directory

        foreach ($Provider in $CDProviders) {
            It "Should have a correctly named Creator script" {
                Get-ChildItem -Path "$($Provider.FullName)/Start-$($Provider.Name)CDCreator.ps1"
            }
        }
    }

    Context "All Providers have an Auth function" {

        $Providers = @((Get-ChildItem -Path "$PSScriptRoot/.." -Directory | Where-Object { $_.Name -match "Repository|CI|CD" } | Get-ChildItem -Directory).Name) |
            Sort-Object -Unique

        $AuthFunctions = @((Get-ChildItem -Path "$PSScriptRoot/../Auth/*.ps1").Name)

        foreach ($Provider in $Providers) {
            It "$Provider has an Auth function" {
                ($AuthFunctions -contains "Initialise-$($Provider)Provider.ps1") | Should Be $true
            }
        }
    }
}
