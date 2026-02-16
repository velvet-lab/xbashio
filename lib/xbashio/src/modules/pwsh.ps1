
$exist = Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue
if ($null -ne $exist) {
    Unregister-PSRepository -Name PSGallery -ErrorAction SilentlyContinue
}
$exist = Get-PSRepository -Name "Artifactory" -ErrorAction SilentlyContinue
if ($null -eq $exist) {
    Register-PSRepository -Name Artifactory -SourceLocation https://packages.repo.dvint.de/artifactory/api/nuget/nuget-powershellgallery-proxy/ -InstallationPolicy Trusted -ErrorAction SilentlyContinue
}