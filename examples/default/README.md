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
  location               = "northeurope"
  other_subscription_ids = [var.other_subscription_id]
}

output "response" {
  value = module.zone_peers_westus2.response
}

output "equiv_az_1" {
  value = module.zone_peers_westus2.response["1"][var.other_subscription_id].zone
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

### <a name="output_equiv_az_1"></a> [equiv\_az\_1](#output\_equiv\_az\_1)

Description: n/a

### <a name="output_response"></a> [response](#output\_response)

Description: n/a

## Modules

The following Modules are called:

### <a name="module_zone_peers_westus2"></a> [zone\_peers\_westus2](#module\_zone\_peers\_westus2)

Source: ../../

Version:


<!-- END_TF_DOCS -->