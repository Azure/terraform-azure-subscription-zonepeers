output "response" {
  value = { for peer in jsondecode(data.azapi_resource_action.this.output).availabilityZonePeers : peer.availabilityZone =>
    {
      for p in peer.peers : p.subscriptionId => {
        zone = tonumber(p.availabilityZone)
      }
    }
  }
  description = <<DESCRIPTION
A map of this subscription's availability zones, to a map of subscription IDs to zone numbers.

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
DESCRIPTION
}
