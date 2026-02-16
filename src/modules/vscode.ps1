$extensionsConfigFile = Join-Path -Path "~" -ChildPath ".devcontainer/devcontainer.json"
$extensionsConfig = Get-Content -Path $extensionsConfigFile | ConvertFrom-Json
$extensionsHome = Join-Path -Path "~" -ChildPath ".vscode-server/extensions"
$extensions = $extensionsConfig.customizations.vscode.extensions
# $codeBinary = Join-Path -Path $(Split-Path -Path $(Get-ChildItem /vscode/vscode-server/ -Filter ("code-server") -Recurse) -Parent) -ChildPath "remote-cli/code"
$codeBinary = (Get-ChildItem /vscode/vscode-server/ -Filter ("code-server") -Recurse).FullName

$extensions | ForEach-Object -Process {
    $extensionName = $_

    if (-not($extensionName.StartsWith("-"))) {
        $exists = Get-ChildItem -Path $extensionsHome -Depth 0 -Directory | Where-Object -FilterScript { $_.Name -match $extensionName }
        if ($null -eq $exists) {
            . $codeBinary --install-extension "${extensionName}" --force
        }
        else {
            Write-Host "'${extensionName}' is already installed"
        }
    }
    else {
        Write-Host "'${extensionName}' is disabled for install"
    }
}