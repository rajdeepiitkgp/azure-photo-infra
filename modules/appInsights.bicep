param name string
param location string

resource ai 'microsoft.insights/components@2020-02-02' = {
  name: name
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 90
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    // WorkspaceResourceId, Flow_Type, etc. can be added if required  
  }
}

output appInsightsId string = ai.id
output instrumentationKey string = ai.properties.InstrumentationKey
