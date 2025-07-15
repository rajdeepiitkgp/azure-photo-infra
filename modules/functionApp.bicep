param name string
param location string
param serverFarmId string
param identityId string
param appInsightsKey string

resource func 'Microsoft.Web/sites@2024-04-01' = {
  name: name
  location: location
  kind: 'functionapp'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityId}': {}
    }
  }
  properties: {
    serverFarmId: serverFarmId
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsKey
        }
        // Add any other required settings here  
      ]
      // numberOfWorkers, alwaysOn, etc. can be added if needed  
    }
    httpsOnly: true
  }
}

output functionAppId string = func.id
