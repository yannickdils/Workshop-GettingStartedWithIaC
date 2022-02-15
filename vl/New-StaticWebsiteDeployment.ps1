[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]
    $StorageAccountName,
    [Parameter(Mandatory = $true)]
    [string]
    $PathToSimpleStaticSite,
    [Parameter(Mandatory = $false)]
    [string]
    $IndexDocumentPath = "index.html",
    [Parameter(Mandatory = $false)]
    [string]
    $ErrorDocument404Path = "error.html"

)

# Determines how PowerShell responds to a non-terminating error
$ErrorActionPreference = 'Stop' 

$pathExists = Test-Path -Path $PathToSimpleStaticSite
if ($pathExists -eq $false) {
    throw "Path does not exist: '$PathToSimpleStaticSite'"
}

$azureContext = (Get-AzContext)
if ($null -eq $azureContext) {
    throw "Please log in to Azure before running this script."
}

$storageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName

# Enable the static website feature on the storage account.
$ctx = $storageAccount.Context
Enable-AzStorageStaticWebsite -Context $ctx -IndexDocument $IndexDocumentPath -ErrorDocument404Path $ErrorDocument404Path

# Add the two HTML pages.
Get-ChildItem -Path $PathToSimpleStaticSite  -File -Recurse | Set-AzStorageBlobContent -Container '$web' # 👈 Use single quotes to  escape the dollar sign!
