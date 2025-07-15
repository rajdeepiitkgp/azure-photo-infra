param name string
param location string
param skuName string = 'F1'
param skuTier string = 'Free'
param kind string = 'app' // or 'functionapp'  

resource asp 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: name
  location: location
  sku: {
    name: skuName
    tier: skuTier
    size: skuName
    capacity: 0
  }
  kind: kind
  properties: {
    perSiteScaling: false
    reserved: (kind == 'linux')
    // add more if needed  
  }
}

output appServicePlanId string = asp.id
