function Get-PipelineProvider {
    param(
        [ValidateSet("Repository", "CI", "CD")]
        [string]$ProviderType
    )
    return [string[]](Get-ChildItem -Path "$PSScriptRoot/../$ProviderType" -Directory).Name
}
