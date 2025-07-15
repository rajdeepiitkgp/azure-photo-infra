@description('Resource location')
param location string = 'eastus'

@description('Name for main storage account')
param storageAccountName string = 'photogalleryrg8638'

@description('Name for secondary storage account')
param storageAccountSecondaryName string = 'photogallerystorage10069'

@description('Cosmos DB Account Name')
param cosmosDbName string = 'photogallerydb'

@description('App Service Plan for WebApp')
param appServicePlanName string = 'ASP-PhotoGalleryRG-b8c5'

@description('App Service Plan for Function')
param functionPlanName string = 'ASP-PhotoGalleryRG-a46b'

@description('WebApp Name')
param webAppName string = 'photogalaryapp'

@description('Function app Name')
param functionAppName string = 'photoevent10069'

@description('App Insights for WebApp')
param appInsightsWebName string = 'photogalaryapp'

@description('App Insights for Function App')
param appInsightsFuncName string = 'photoevent10069'

@description('UserAssignedManagedIdentity for Web App')
param webAppIdentityName string = 'PhotoGalaryIdentity'

@description('UserAssignedManagedIdentity for Function')
param functionAppIdentityName string = 'photoevent10069-id-b937'

// Storage Accounts  
module storageAccountModule './modules/storageAccount.bicep' = {
  name: 'storageAccountModule'
  params: {
    name: storageAccountName
    location: location
    kind: 'Storage'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
  }
}

module storageAccountSecondaryModule './modules/storageAccount.bicep' = {
  name: 'storageAccountSecondaryModule'
  params: {
    name: storageAccountSecondaryName
    location: location
    kind: 'StorageV2'
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_0'
  }
}

// Cosmos DB  
module cosmosModule './modules/cosmosDb.bicep' = {
  name: 'cosmosDbModule'
  params: {
    name: cosmosDbName
    location: location
  }
}

// App Insights  
module appInsightsWebModule './modules/appInsights.bicep' = {
  name: 'appInsightsWebModule'
  params: {
    name: appInsightsWebName
    location: location
  }
}

module appInsightsFuncModule './modules/appInsights.bicep' = {
  name: 'appInsightsFuncModule'
  params: {
    name: appInsightsFuncName
    location: location
  }
}

// Managed Identities  
module webAppIdentityModule './modules/managedIdentity.bicep' = {
  name: 'webAppIdentityModule'
  params: {
    name: webAppIdentityName
    location: location
  }
}

module functionAppIdentityModule './modules/managedIdentity.bicep' = {
  name: 'functionAppIdentityModule'
  params: {
    name: functionAppIdentityName
    location: location
  }
}

// App Service Plan (Web App)  
module appServicePlanModule './modules/appServicePlan.bicep' = {
  name: 'appServicePlanModule'
  params: {
    name: appServicePlanName
    location: location
    skuName: 'F1'
    skuTier: 'Free'
    kind: 'app'
  }
}

// App Service Plan (Function)  
module functionPlanModule './modules/appServicePlan.bicep' = {
  name: 'functionPlanModule'
  params: {
    name: functionPlanName
    location: location
    skuName: 'Y1'
    skuTier: 'Dynamic'
    kind: 'functionapp'
  }
}

// Web App  
module webAppModule './modules/appService.bicep' = {
  name: 'webAppModule'
  params: {
    name: webAppName
    location: location
    serverFarmId: appServicePlanModule.outputs.appServicePlanId
    identityId: webAppIdentityModule.outputs.identityId
    appInsightsKey: appInsightsWebModule.outputs.instrumentationKey
  }
}

// Function App  
module functionAppModule './modules/functionApp.bicep' = {
  name: 'functionAppModule'
  params: {
    name: functionAppName
    location: location
    serverFarmId: functionPlanModule.outputs.appServicePlanId
    identityId: functionAppIdentityModule.outputs.identityId
    appInsightsKey: appInsightsFuncModule.outputs.instrumentationKey
  }
}

// Static Web App (example, you may parameterize as with the others)  
module staticWebAppModule './modules/staticWebApp.bicep' = {
  name: 'staticWebAppModule'
  params: {
    name: 'azure-photo-ui'
    location: 'eastus2'
    repoUrl: 'https://github.com/rajdeepiitkgp/azure-photo-ui'
    branch: 'main'
  }
}
