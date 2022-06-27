param enforcementMode string = 'Default'

var policyDetails = {
  policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9'
  assignmentName: 'audit-securetransfer'
  description: 'Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking'
  displayName: 'Secure transfer to storage accounts should be enabled'
}

resource pol 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: policyDetails.assignmentName
  properties: {
    policyDefinitionId: policyDetails.policyDefinitionId
    description: policyDetails.description
    displayName: policyDetails.displayName
    enforcementMode: enforcementMode
  }
}
