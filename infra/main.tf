resource "azurerm_resource_group" "rg" {
  name     = "${var.environment}-rg"
  location = "East US"

  tags = {
    environment = var.environment
  }
}
#test
resource "azurerm_service_plan" "app_plan" {
  name                = "${var.environment}-app-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "${var.environment}-ccseyhan-appservice"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    application_stack {
      docker_image = "ccseyhan/rdicidr"
      docker_image_tag = "0.1.0"
    }
  }
}