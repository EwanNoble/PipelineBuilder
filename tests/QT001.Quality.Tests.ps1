Describe "Code quality tests" -Tag "Quality" {

    $Scripts = Get-ChildItem -Path "$PSScriptRoot/.." -Include *.ps1 -Exclude *tests* -File -Recurse

    $Rules = Get-ScriptAnalyzerRule
    $ExcludeRules = @(
        "PSAvoidUsingWriteHost",
        "PSUseShouldProcessForStateChangingFunctions"
    )

    foreach ($Script in $Scripts) {
        Context $Script.BaseName {
            forEach ($Rule in $Rules) {
                It "Should pass Script Analyzer rule $Rule" {
                    $Result = Invoke-ScriptAnalyzer -Path $Script.FullName -IncludeRule $Rule -ExcludeRule $ExcludeRules
                    $Result.Count | Should Be 0
                }
            }

            It "Should have a unit test file" {
                $Result = Get-ChildItem -Path "$PSScriptRoot\*$($Script.BaseName).Tests.ps1" -File -Recurse
                $Result.Count | Should Be 1
            }
        }
    }
}
