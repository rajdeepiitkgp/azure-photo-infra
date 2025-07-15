param name string
param location string
param kind string = 'StorageV2' // Storage or StorageV2  
param allowBlobPublicAccess bool = false
param minimumTlsVersion string = 'TLS1_2' // 'TLS1_2' or 'TLS1_0'  

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: kind
  properties: {
    allowBlobPublicAccess: allowBlobPublicAccess
    minimumTlsVersion: minimumTlsVersion
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

output storageAccountId string = storage.id
