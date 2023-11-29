<!-- BEGIN_TF_DOCS -->
# Default example

This example shows how get the zone peers for a given subscription vs. another subscription.

```hcl
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
```

<!-- markdownlint-disable MD033 -->
## Requirements

No requirements.

## Providers

No providers.

## Resources

No resources.

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_other_subscription_id"></a> [other\_subscription\_id](#input\_other\_subscription\_id)

Description: n/a

Type: `string`

### <a name="input_this_subscription_id"></a> [this\_subscription\_id](#input\_this\_subscription\_id)

Description: n/a

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_equiv_of_az_1_in_other_subscription"></a> [equiv\_of\_az\_1\_in\_other\_subscription](#output\_equiv\_of\_az\_1\_in\_other\_subscription)

Description: This ensures that the same physical zone is used in both subscriptions.

### <a name="output_response"></a> [response](#output\_response)

Description: n/a

## Modules

The following Modules are called:

### <a name="module_zone_peers_westus2"></a> [zone\_peers\_westus2](#module\_zone\_peers\_westus2)

Source: ../../

Version:


<!-- END_TF_DOCS -->