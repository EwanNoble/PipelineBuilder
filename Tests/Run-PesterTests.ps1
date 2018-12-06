$RequiredModules = @("Pester", "PSScriptAnalyzer")
foreach ($Module in $RequiredModules) {
    if (!(Get-Module -Name $Module -ListAvailable)) {
        Write-Verbose "Installing $Module"
        Install-Module -Name $Module -Scope CurrentUser -Force
    }
}

Invoke-Pester
