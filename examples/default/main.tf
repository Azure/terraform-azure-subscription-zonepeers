variable "this_subscription_id" {
  type = string
}

variable "other_subscription_id" {
  type = string
}

module "zone_peers_westus2" {
  source                 = "../../"
  this_subscription_id   = var.this_subscription_id
  location               = "westus2"
  other_subscription_ids = [var.other_subscription_id]
}

output "response" {
  value = module.zone_peers_westus2.response
}

# This ensures that the same physical zone is used in both subscriptions.
output "equiv_of_az_1_in_other_subscription" {
  value = module.zone_peers_westus2.response[var.other_subscription_id].zone["1"]
}
