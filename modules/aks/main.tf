resource "azurerm_kubernetes_cluster" "example" {
  name                = "mykubernetescluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "mykubernetesclusterdns"
  kubernetes_version  = "1.21.2"


  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
	enabled                    = true
	log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
  }
	ingress_application_gateway  {
	enabled                    = true 
    gateway_id                 = data.azurerm_application_gateway.this.id
	# subnet_cidr                = "10.1.0.0/16"
	# gateway_name               = "${azurerm_kubernetes_cluster}-AGIC"
	} 
 } 

}