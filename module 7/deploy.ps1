# Authenticate to your Azure Tenant & Subscription

$SubscriptionID = "5c58c666-d960-46d6-8242-c1073d5df2b1"
$ResourceGroupInitials = "ydi"
Login-AzAccount -Subscription $SubscriptionID

# Create the service principal - Run this account in Azure CLI
$SubscriptionID = "5c58c666-d960-46d6-8242-c1073d5df2b1"
$ResourceGroupInitials = "ydi"
az ad sp create-for-rbac --name ydiapp --role contributor --scopes "/subscriptions/5c58c666-d960-46d6-8242-c1073d5df2b1/resourceGroups/hogent-ydi-rg" --sdk-auth

# Run the following command to deploy the bicep template




$resourcegroupname = "rg-weu-ydi"
New-AzResourceGroupDeployment -TemplateFile main.bicep -ResourceGroupName $resourcegroupname