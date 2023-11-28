variable "this_subscription_id" {
  type        = string
  description = "The subscription id to check for zone peers from."
}

variable "location" {
  type        = string
  description = "The Azure location to check for zone peers, e.g. `westus2`."
}

variable "other_subscription_ids" {
  type        = set(string)
  description = "A set of subscription IDs to check for zone peers to."
}
