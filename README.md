<!-- BEGIN_TF_DOCS -->
# terraform-azure-subscription-zonepeers

This module is used to get the zone peers for a given subscription vs. a set of other subscriptions.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.6.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (>= 1.9.0, <= 2.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_azapi"></a> [azapi](#provider\_azapi) (1.10.0)

## Resources

The following resources are used by this module:

- [azapi_resource_action.this](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/resource_action) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_location"></a> [location](#input\_location)

Description: The Azure location to check for zone peers, e.g. `westus2`.

Type: `string`

### <a name="input_other_subscription_ids"></a> [other\_subscription\_ids](#input\_other\_subscription\_ids)

Description: A set of subscription IDs to check for zone peers to.

Type: `set(string)`

### <a name="input_this_subscription_id"></a> [this\_subscription\_id](#input\_this\_subscription\_id)

Description: The subscription id to check for zone peers from.

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_response"></a> [response](#output\_response)

Description: A map of this subscription's availability zones, to a map of subscription IDs to zone numbers.

E.g.

To get the equivalent AZ `1` for another subscription in `westus2`, you can do:

```hcl
module "zone_peers_westus2" {
  source                 = "../../"
  this_subscription_id   = var.this_subscription_id
  location               = "westus2"
  other_subscription_ids = [var.other_subscription_id]
}

locals {
  other_az = module.zone_peers_westus2.response["1"][var.other_subscription_id].zone
}
```

## Modules

No modules.


<!-- END_TF_DOCS -->