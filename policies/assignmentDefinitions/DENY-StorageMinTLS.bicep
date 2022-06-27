param effect string

@allowed([
  'TLS1_2'
  'TLS1_1'
  'TLS1_0'
])
param minimumTlsVersion string

var policyDetails = {
  policyDefinitionId: '/providers/Microsoft.Management/managementGroups/contoso/providers/Microsoft.Authorization/policyDefinitions/Deny-Storage-minTLS'
  assignmentName: 'deny-storagemintls'
  description: 'Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking'
  displayName: 'Storage Account set to minumum TLS and Secure transfer should be enabled'
}

resource pol 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: policyDetails.assignmentName
  properties: {
    policyDefinitionId: policyDetails.policyDefinitionId
    description: policyDetails.description
    displayName: policyDetails.displayName
    enforcementMode: 'Default'
    parameters: {
      effect: {
        value: effect
      }
      minimumTlsVersion: {
        value: minimumTlsVersion
      }
    }
  }
}
