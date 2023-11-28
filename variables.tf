variable "this_subscription_id" {
  type = string
}

variable "location" {
  type = string
}

variable "other_subscription_ids" {
  type = set(string)
}
