

resource ydidemostorage 'Microsoft.Storage/storageAccounts@2021-08-01' = {

  name: 'ydidemostorageaccount'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
      }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    
  }
}
