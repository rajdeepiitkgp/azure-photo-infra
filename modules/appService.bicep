param name string
param location string
param serverFarmId string
param identityId string
param appInsightsKey string

resource app 'Microsoft.Web/sites@2024-04-01' = {
  name: name
  location: location
  kind: 'app'
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
        // Add other settings as required  
      ]
    }
    httpsOnly: true
  }
}

output appServiceId string = app.id
