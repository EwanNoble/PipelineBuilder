. "$PSScriptRoot/Helpers/Helpers.ps1"
Get-ChildItem -Path "$PSScriptRoot/Repository/$RepositoryProvider/**/*.ps1" -Recurse | ForEach-Object { . $_ }
Get-ChildItem -Path "$PSScriptRoot/CI/$CIProvider/**/*.ps1" -Recurse | ForEach-Object { . $_ }
Get-ChildItem -Path "$PSScriptRoot/CD/$CDProvider/**/*.ps1" -Recurse | ForEach-Object { . $_ }

function Start-PipelineCreator {
    param(
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [ValidateScript( {!($_.Contains(" "))})]
        [string]$ProjectName,
        [Parameter(Position = 1, Mandatory = $true)]
        [ArgumentCompleter( { Get-PipelineProviders -ProviderType "Repository" })]
        [ValidateScript( { $_ -in (Get-PipelineProviders -ProviderType "Repository") })]
        [string]$RepositoryProvider,
        [Parameter(Position = 2, Mandatory = $true)]
        [ArgumentCompleter( { Get-PipelineProviders -ProviderType "CI" })]
        [ValidateScript( { $_ -in (Get-PipelineProviders -ProviderType "CI") })]
        [string]$CIProvider,
        [Parameter(Position = 3, Mandatory = $true)]
        [ArgumentCompleter( { Get-PipelineProviders -ProviderType "CD" })]
        [ValidateScript( { $_ -in (Get-PipelineProviders -ProviderType "CD") })]
        [string]$CDProvider
    )

    ### Repo Creation

    $RepoCreatorCommand = "Start-$($RepositoryProvider)RepositoryCreator"
    Write-Verbose "Invoking $RepoCreatorCommand"
    & $RepoCreatorCommand

    ### CI Creation

    $CICreatorCommand = "Start-$($CIProvider)CICreator"
    Write-Verbose "Invoking $CICreatorCommand"
    & $CICreatorCommand

    ### CD Creation

    $CDCreatorCommand = "Start-$($CDProvider)CDCreator"
    Write-Verbose "Invoking $CDCreatorCommand"
    & $CDCreatorCommand
}
