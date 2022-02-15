# Exercise: Create and deploy Azure Bicep templates by using Visual Studio Code

For your toy launch website, you decide to first create a proof of concept by creating a basic Bicep template. In this exercise, you'll create a storage account, Azure App Service plan, and app. Later, you'll modify the template to make it more reusable.

During the process, you'll:

1. Create a template that defines a single storage account resource that includes hard-coded values.
1. Provision your infrastructure and verify the result.
1. Add an App Service plan and app to the template.
1. Provision the infrastructure again to see the new resources.

## Prerequisites

- An Azure account with an active subscription. If you don't already have one, ask your instructor.
- [Visual Studio Code](https://code.visualstudio.com/) with the [Bicep extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) installed.
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/) installed locally
- [Azure PowerShell module](https://www.powershellgallery.com/packages/Az/7.2.0) installed locally

This exercise uses the Bicep extension for Visual Studio Code. Be sure to install this extension in Visual Studio Code.

# Create a Bicep template that contains a storage account

1. Open Visual Studio Code.
2. Create a new file called main.bicep.
3. Save the empty file so that Visual Studio Code loads the Bicep tooling.

You can either select File > Save As or select Ctrl+S in Windows (⌘+S on macOS). Be sure to remember where you've saved the file. For example, you might want to create a templates folder to save it in.

4 Add the following content into the file. You'll deploy the template soon. It's a good idea to type this in yourself instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

```bicep
    resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
      name: 'toylaunchstorage'
      location: 'eastus'
      sku: {
        name: 'Standard_LRS'
      }
      kind: 'StorageV2'
      properties: {
        accessTier: 'Hot'
      }
    }
```

> 💡 Bicep is strict about where you put line breaks, so make sure you don't put line breaks in different places than what's listed here.

Notice that Visual Studio Code automatically suggests property names as you type. The Bicep extension for Visual Studio Code understands the resources you're defining in your template, and it lists the available properties and values that you can use.

5. Update the name of the storage account from toylaunchstorage to something that's likely to be unique. Make sure the name is all lowercase, without any special characters, and fewer than 24 characters.
6. Save the changes to the file.

## Deploy the Bicep template to Azure

To deploy this template to Azure, sign in to your Azure account from the Visual Studio Code terminal.

1. Open a Visual Studio Code terminal window by selecting Terminal > New Terminal. The window usually opens at the bottom of the screen.
2. If the dropdown control at the right displays pwsh or PowerShell, you have the right shell to work from, and you can skip to the next section.
![Screenshot of the Visual Studio Code terminal window, with the pwsh option displayed in the dropdown control.](img/m51.png)
If pwsh or PowerShell isn't displayed, select the dropdown control, choose Select Default Shell, and then select pwsh or PowerShell.
![Screenshot of the Visual Studio Code terminal window, with the Select your preferred terminal shell dropdown list shown.](img/m52.png)
3. Select the plus sign (+) in the terminal to create a new terminal with pwsh or PowerShell as the shell.
4. You might have to switch your terminal to the directory where you saved your template. For example, if you saved it to the templates folder, you can use this command:

```powershell
cd templates
```

## Install the Bicep CLI

To use Bicep from Azure PowerShell, [install the Bicep CLI](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/bicep-install?tabs=azure-powershell#install-manually).

## Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command:

```powershell
Connect-AzAccount
```

A browser opens so that you can sign in to your Azure account.

2. After you've signed in to Azure, the terminal displays a list of the subscriptions associated with this account.

3. Set the default subscription for all of the Azure PowerShell commands that you run in this session.

```powerShell
$context = Get-AzSubscription -SubscriptionName 'Concierge Subscription'
Set-AzContext $context
```

> ⚠️ If you've used more than one subscription recently, the terminal might display more than one subscriptions. In this case, use the next two steps to set one as the default subscription. If the preceding command was successful, and only one subscription is listed, skip the next two steps.

4. Get the subscription ID. Running the following command lists your subscriptions and their IDs. Look for Concierge Subscription, and then copy the ID from the second column. It looks something like cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0.

```PowerShell
Get-AzSubscription
```

5. Change your active subscription to Concierge Subscription. Be sure to replace {Your subscription ID} with the one that you copied.

```PowerShell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
```

## Set the default resource group

You can set the default resource group and omit the parameter from the rest of the Azure PowerShell commands in this exercise. Set this default to the resource group created for you in the environment.

```powershell
Set-AzDefault -ResourceGroupName [resource group name]
```

## Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take a minute or two to complete, and then you'll see a successful deployment.

```PowerShell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

## Verify the deployment

The first time you deploy a Bicep template, you might want to use the Azure portal to verify that the deployment has finished successfully and to inspect the results.

1. Go to the [Azure portal](https://portal.azure.com/) and make sure you're in the subscription:
2. Select your avatar in the upper-right corner of the page.
3. Select Switch directory. In the list, choose the instructor's directory.
4. On the left-side panel, select Resource groups.
5. Select [esource group name].
6. In Overview, you can see that one deployment succeeded.
![Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded.](img/m53.png)
7. Select 1 Succeeded to see the details of the deployment.
![Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status.](img/m54.png)
8. Select the deployment called main to see what resources were deployed, and then select Deployment details to expand it. In this case, there's one storage account with the name that you specified.
[Screenshot of the Azure portal interface for the specific deployment, with one storage account resource listed.](img/m55.png)
9. Leave the page open in your browser. You'll check on deployments again later.

You can also verify the deployment from the command line. To do so, run the following Azure PowerShell command:

```poweshell
Get-AzResourceGroupDeployment -ResourceGroupName [resource group name] | Format-Table
```
