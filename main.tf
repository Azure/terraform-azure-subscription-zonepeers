data "azapi_resource_action" "this" {
  type        = "Microsoft.Resources/subscriptions@2022-12-01"
  method      = "POST"
  resource_id = "/subscriptions/${var.this_subscription_id}"
  action      = "providers/Microsoft.Resources/checkZonePeers/"
  body = jsonencode({
    location        = var.location
    subscriptionIds = [for id in var.other_subscription_ids : "/subscriptions/${id}"]
  })
  response_export_values = ["*"]
}
