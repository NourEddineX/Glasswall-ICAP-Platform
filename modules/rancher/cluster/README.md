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
| azure\_region | The Cloud Region | `string` | n/a | yes |
| cluster\_name | Bootstrap the virtual machine with this file | `string` | n/a | yes |
| cluster\_network\_plugin | Set the network plugin | `string` | `"canal"` | no |
| kubernetes\_version | The Kubernetes version | `string` | `"v1.19.2-rancher1-1"` | no |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |
| service\_name | The Service Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| kubernetes\_version | n/a |
| name | n/a |
| resource\_group | n/a |
