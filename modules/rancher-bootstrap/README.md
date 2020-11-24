## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| rancher2 | 1.10.3 |
| rancher2.bootstrap | 1.10.3 |
| random | n/a |
| time | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | Set the Azure Region | `string` | n/a | yes |
| custom\_data\_file\_path | Bootstrap the virtual machine with this file | `string` | n/a | yes |
| environment | Metadata Environment | `string` | n/a | yes |
| network\_addresses | Network Addresses | `list(string)` | <pre>[<br>  "10.10.0.0/16"<br>]</pre> | no |
| organisation | Metadata Organisation | `string` | n/a | yes |
| project | Metadata Project | `string` | n/a | yes |
| subnet\_address\_prefixes | Subnet CIDR | `list(string)` | <pre>[<br>  "10.10.2.0/24"<br>]</pre> | no |
| subnet\_prefix | Subnet Prefix | `string` | `"10.10.2.0/24"` | no |
| suffix | Metadata Project Suffix (so that we can create multiple instances) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| admin\_password | n/a |
| admin\_token | n/a |
| admin\_token\_id | n/a |
| admin\_url | n/a |
| admin\_user | n/a |
| git\_server\_public\_ips | n/a |
| git\_server\_url | n/a |
| gitserver\_security\_group\_id | n/a |
| linux\_vm\_private\_ips | n/a |
| linux\_vm\_public\_ips | n/a |
| network\_id | n/a |
| public\_key\_openssh | n/a |
| rancher\_api\_url | n/a |
| rancher\_internal\_api\_url | n/a |
| rancher\_network | n/a |
| rancher\_resource\_group | n/a |
| rancher\_security\_group\_id | n/a |
| tls\_private\_key | n/a |

