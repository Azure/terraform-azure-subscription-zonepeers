# terraform-azure-subscription-zonepeers

This module is used to get the zone peers for a given subscription vs. a set of other subscriptions.

## `AvailabilityZonePeering` provider feature

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
