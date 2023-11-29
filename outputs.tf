locals {
  # input_data is the jsondecoded output of the azapi_resource_action resource.
  input_data = jsondecode(data.azapi_resource_action.this.output).availabilityZonePeers
  # subscription_ids creates the keys for the output_data map.
  subscription_ids = toset(flatten([for azp in local.input_data : [for peer in azp.peers : peer.subscriptionId]]))
  # flattened_data creates list of objects, each containing the other subscription id, the other zone, and the local zone.
  flattened_data = flatten([for azp in local.input_data : [
    for peer in azp.peers : {
      other_subscription_id = peer.subscriptionId
      other_zone            = peer.availabilityZone
      this_zone             = azp.availabilityZone
    }
  ]])
  # output_data creates a map of the other subscription ids supplied,
  # then creates a `zones` attribute, which is a nested map of that subscription's zones to the local zone number.
  # Because we use the ellipses function to handle the duplicate keys, get a `list(number)` for the final value, even though there will only ever be one.
  # To remediate this we pass through another `for` loop and use the `one()` function to get the first value.
  output_data = { for k, v in {
    for sub in local.subscription_ids : sub => {
      zone = {
        for azp in local.flattened_data : (azp.other_zone) => tonumber(azp.this_zone)... if azp.other_subscription_id == sub
      }
    }
    } : k => {
    zone = {
      for zk, zv in v.zone : zk => one(zv)
    }
  } }
}

output "response" {
  value       = local.output_data
  description = <<DESCRIPTION
A map of this subscription's availability zones, to a map of subscription IDs to zone numbers.

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
DESCRIPTION
}
