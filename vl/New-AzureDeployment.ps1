
$azureContext = (Get-AzContext)
if ($null -eq $azureContext) {
    Connect-AzAccount
}

$yourName = "tvl"
$rgName = "hogent-iac-$yourName"

New-AzResourceGroup -Name $rgName `
    -Location "westeurope"

$deploymentResult = New-AzResourceGroupDeployment -ResourceGroupName $rgName `
    -Name (Get-Date -Format 'yyyyMMddHHmmss') `
    -TemplateFile "main.bicep"

. './New-StaticWebsiteDeployment.ps1' -ResourceGroupName $rgName `
    -StorageAccountName $deploymentResult.Outputs['storageAccountName'].Value `
    -PathToSimpleStaticSite "simple-static-site" 
