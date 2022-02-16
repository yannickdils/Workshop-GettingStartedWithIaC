param location string = resourceGroup().location

resource ydidemostorage 'Microsoft.Storage/storageAccounts@2021-08-01' = {


  name: 'ydidemostorageaccount10'
  location: location
  sku: {
    name: 'Standard_LRS'
      }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    
  }
}
