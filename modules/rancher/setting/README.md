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
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |
| setting\_name | Set the name | `string` | n/a | yes |
| setting\_value | Set the value | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |

