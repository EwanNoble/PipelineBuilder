function Start-GitHubRepositoryCreator {
    param()

    Write-Verbose "Installing required modules for GitHub repo creation"
    $RequiredModules = @("PowerShellForGitHub")
    foreach ($Module in $RequiredModules) {
        if (!(Get-Module -Name $Module -ListAvailable)) {
            Write-Verbose "Installing $Module"
            Install-Module -Name $Module -Scope CurrentUser -Force
        }
    }
}
