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
}
