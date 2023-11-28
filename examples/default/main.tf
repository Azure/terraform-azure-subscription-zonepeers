variable "this_subscription_id" {
  type = string
}

variable "other_subscription_ids" {
  type = set(string)
}

module "zone_peers_westus2" {
  source                 = "../../"
  this_subscription_id   = var.this_subscription_id
  location               = "westus2"
  other_subscription_ids = var.other_subscription_ids
}

output "response" {
  value = module.zone_peers_westus2.response
}
