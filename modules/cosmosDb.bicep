param name string
param location string

resource cosmosdb 'Microsoft.DocumentDB/databaseAccounts@2024-12-01-preview' = {
  name: name
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    publicNetworkAccess: 'Enabled'
    enableAutomaticFailover: false
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    networkAclBypass: 'None'
    minimalTlsVersion: 'Tls12'
    // Add more properties as needed, following your export  
  }
}

output cosmosDbId string = cosmosdb.id
output primaryMasterKey string = listKeys(cosmosdb.id, cosmosdb.apiVersion).primaryMasterKey
