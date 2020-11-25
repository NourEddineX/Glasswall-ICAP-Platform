## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| rancher2 | 1.10.3 |

## Providers

| Name | Version |
|------|---------|
| rancher2.admin | 1.10.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_region | The cloud region | `string` | n/a | yes |
| client\_id | Service Principal ClientID | `string` | n/a | yes |
| client\_secret | Service Principal Secret | `string` | n/a | yes |
| cluster\_name | This is the name of the cluster | `string` | n/a | yes |
| cluster\_network\_plugin | Set the network plugin | `string` | `"canal"` | no |
| environment | Metadata Environment | `string` | n/a | yes |
| kubernetes\_version | The Kubernetes version | `string` | `"v1.19.2-rancher1-1"` | no |
| master\_scaleset\_admin\_user | The K8S Master Scaleset admin user | `string` | n/a | yes |
| master\_scaleset\_size | The K8S Master Scaleset size | `string` | n/a | yes |
| master\_scaleset\_sku\_capacity | The K8S Master Scaleset sku capacity | `string` | n/a | yes |
| organisation | Metadata Organisation | `string` | n/a | yes |
| os\_offer | The Linux OS Offer | `string` | n/a | yes |
| os\_publisher | The Linux OS Publisher | `string` | n/a | yes |
| os\_sku | The Linux OS SKU | `string` | n/a | yes |
| os\_version | The Linux OS Version | `string` | `"latest"` | no |
| public\_key\_openssh | The Node SSH key | `string` | n/a | yes |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher admin API | `string` | n/a | yes |
| rancher\_internal\_api\_url | The Rancher internal API url | `string` | n/a | yes |
| resource\_group | the resource group | `string` | n/a | yes |
| scaleset\_name | The scale set name | `string` | n/a | yes |
| subnet\_id | The Subnet ID for the ScaleSet | `string` | n/a | yes |
| subnet\_name | The Subnet Name for the cluster config | `string` | n/a | yes |
| subscription\_id | Service Principal Subscription ID | `string` | n/a | yes |
| tenant\_id | Service Principal TenantID | `string` | n/a | yes |
| virtual\_network\_name | Virtual Network Name | `string` | n/a | yes |
| worker\_lb\_backend\_address\_pool\_id | The K8S Worker Scaleset admin user | `list(string)` | n/a | yes |
| worker\_lb\_probe\_id | The K8S Worker LB Probe ID from Infra module | `string` | n/a | yes |
| worker\_scaleset\_admin\_user | The K8S Worker Scaleset admin user | `string` | n/a | yes |
| worker\_scaleset\_size | The K8S Worker Scaleset size | `string` | n/a | yes |
| worker\_scaleset\_sku\_capacity | The K8S Worker Scaleset sku capacity | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| access\_key | n/a |
| cluster\_id | n/a |
| cluster\_name | n/a |
| crt\_cluster\_id | n/a |
| crt\_cluster\_node\_command | n/a |
| crt\_cluster\_token | n/a |
| kubernetes\_version | n/a |
| secret\_key | n/a |
| token | n/a |
| token\_enabled | n/a |
| token\_name | n/a |

