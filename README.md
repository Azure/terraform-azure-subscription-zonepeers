<!-- BEGIN_TF_DOCS -->
# terraform-azure-subscription-zonepeers

This module is used to get the zone peers for a given subscription vs. a set of other subscriptions.
You need one instance of this module for each Azure location you want to query.

```terraform
module "zone_peers_westus2" {
  source                 = "../../"
  this_subscription_id   = var.this_subscription_id
  location               = "westus2"
  other_subscription_ids = [var.other_subscription_id]
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "westus2"
}

# This places the resource in the same physical zone as the
# resource deployed into logical zone 2 in the other subscription.
resource "azurerm_public_ip" "example" {
  name                = "example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [module.zone_peers_westus2.response[var.other_subscription_id].zone["2"]]
}
```

## Example output

A map keyed by the other subscription ids is returned. Each value is a map of the zones in the other subscription to the zone in the current subscription that is in the same physical zone.

```terraform
response = {
  "00000000-0000-0000-0000-000000000000" = {   # Other subscription id
    "zone" = {
      "1" = 1    # Key "1" is the zone in the other subscription, value `1` is the zone in the current subscription
      "2" = 3    # Key "2" is the zone in the other subscription, value `3` is the zone in the current subscription
      "3" = 2    # Key "3" is the zone in the other subscription, value `2` is the zone in the current subscription
    }
  }
}
```

## Required provider feature: `AvailabilityZonePeering`

This module requires a provider feature to be registered in the subscription defined by `var.this_subscription_id`.

```bash
az feature register -n AvailabilityZonePeering --namespace Microsoft.Resources
```

Check registration status with:

```bash
az feature show -n AvailabilityZonePeering --namespace Microsoft.Resources
```

After this feature is registered, you should re-register the provider to propagate the change.

```bash
az provider register -n Microsoft.Resources
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.6.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (>= 1.9.0, <= 2.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_azapi"></a> [azapi](#provider\_azapi) (>= 1.9.0, <= 2.0.0)

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

If you have a resource deployed in `var.other_subscription_id` in zone `1` in `var.location`, then you can get the equivalent zone in this subscription with:

```hcl
module "zone_peers_westus2" {
  source                 = "../../"
  this_subscription_id   = var.this_subscription_id
  location               = "westus2"
  other_subscription_ids = [var.other_subscription_id]
}

locals {
  this_sub_equiv_az = module.zone_peers_westus2.response[var.other_subscription_id].zone["1"]
}
```

## Modules

No modules.


<!-- END_TF_DOCS -->