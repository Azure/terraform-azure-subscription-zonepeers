variable "this_subscription_id" {
  type        = string
  description = "The subscription id to check for zone peers from."

  validation {
    condition     = can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.this_subscription_id))
    error_message = "The subscription id must be a valid Azure subscription id (letters in lowercase)."
  }
}

variable "location" {
  type        = string
  description = "The Azure location to check for zone peers, e.g. `westus2`."
}

variable "other_subscription_ids" {
  type        = set(string)
  description = "A set of subscription IDs to check for zone peers to."

  validation {
    condition = alltrue(
      [for id in var.other_subscription_ids : can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", id))]
    )
    error_message = "The subscription id must be a valid Azure subscription id (letters in lowercase)."
  }
}
