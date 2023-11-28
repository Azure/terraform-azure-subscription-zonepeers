variable "this_subscription_id" {
  type = string
}

variable "other_subscription_id" {
  type = string
}

module "zone_peers_westus2" {
  source                 = "../../"
  this_subscription_id   = var.this_subscription_id
  location               = "northeurope"
  other_subscription_ids = [var.other_subscription_id]
}

output "response" {
  value = module.zone_peers_westus2.response
}

output "equiv_az_1" {
  value = module.zone_peers_westus2.response["1"][var.other_subscription_id].zone
}
