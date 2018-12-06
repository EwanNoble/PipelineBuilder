function Start-AzureCICreator {
    param()

    Write-Verbose "Installing required modules for Azure CI creation"
    $RequiredModules = @("VSTeam")
    foreach ($Module in $RequiredModules) {
        if (!(Get-Module -Name $Module -ListAvailable)) {
            Write-Verbose "Installing $Module"
            Install-Module -Name $Module -Scope CurrentUser -Force
        }
    }
}
