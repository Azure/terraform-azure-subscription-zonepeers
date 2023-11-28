<!-- BEGIN_TF_DOCS -->
# Default example

This example shows how to deploy the module in its simplest configuration.

```hcl
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

### <a name="input_other_subscription_ids"></a> [other\_subscription\_ids](#input\_other\_subscription\_ids)

Description: n/a

Type: `set(string)`

### <a name="input_this_subscription_id"></a> [this\_subscription\_id](#input\_this\_subscription\_id)

Description: n/a

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_response"></a> [response](#output\_response)

Description: n/a

## Modules

The following Modules are called:

### <a name="module_zone_peers_westus2"></a> [zone\_peers\_westus2](#module\_zone\_peers\_westus2)

Source: ../../

Version:


<!-- END_TF_DOCS -->