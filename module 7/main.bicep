param location string = resourceGroup().location
param storageAccountName string = 'store${uniqueString(resourceGroup().id)}'

resource myStorage 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {}
}
