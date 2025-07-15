param name string
param location string

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  name: name
  location: location
}

output identityId string = identity.id
