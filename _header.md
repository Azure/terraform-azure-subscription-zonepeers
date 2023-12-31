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

## Required provider feature: `AvailabilityZonePeering``

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
