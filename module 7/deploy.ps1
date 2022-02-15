# Authenticate to your Azure Tenant & Subscription

$SubscriptionID = ""
Login-AzAccount -Subscription $SubscriptionID

# Run the following command to deploy the bicep template

$resourcegroupname = "rg-weu-ydi"
New-AzResourceGroupDeployment -TemplateFile main.bicep -ResourceGroupName $resourcegroupname