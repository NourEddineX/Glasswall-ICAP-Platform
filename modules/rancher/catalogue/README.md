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
| helm\_charts\_repo\_branch | The branch name of the repo to the helm charts | `string` | n/a | yes |
| helm\_charts\_repo\_url | The repo url to the helm charts | `string` | n/a | yes |
| rancher\_admin\_token | The Rancher Admin Token | `string` | n/a | yes |
| rancher\_admin\_url | The Rancher API | `string` | n/a | yes |

## Outputs

No output.

