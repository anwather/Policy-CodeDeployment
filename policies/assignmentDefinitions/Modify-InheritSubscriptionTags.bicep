param tagName string
param deploymentManagementGroup string

var policyDetails = {
  policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/40df99da-1232-49b1-a39a-6da8d878f469'
  assignmentName: 'modify-inherittags'
  description: 'Adds the specified tag with its value from the containing subscription when any resource missing this tag is created or updated.'
  displayName: 'Inherit a tag from the subscription if missing'
  roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
}

resource pol 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: policyDetails.assignmentName
  identity: {
    type: 'SystemAssigned'
  }
  location: 'australiaeast'
  properties: {
    policyDefinitionId: policyDetails.policyDefinitionId
    description: policyDetails.description
    displayName: policyDetails.displayName
    enforcementMode: 'Default'
    parameters: {
      tagName: {
        value: tagName
      }
    }
  }
}

resource role 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: guid(deploymentManagementGroup, policyDetails.assignmentName, tagName)
  properties: {
    principalId: toLower(reference('/providers/Microsoft.Authorization/policyAssignments/${policyDetails.assignmentName}', '2021-06-01', 'full').identity.principalId)
    roleDefinitionId: policyDetails.roleDefinitionId
    principalType: 'ServicePrincipal'
  }
  dependsOn: [
    pol
  ]
}
