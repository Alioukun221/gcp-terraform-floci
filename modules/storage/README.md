# Storage Module

Creates a Google Cloud Storage bucket with uniform bucket-level access,
optional object versioning, and configurable storage class.

Documentation generated with [terraform-docs](https://terraform-docs.io):

```bash
terraform-docs markdown table --output-file README.md --output-mode inject modules/storage
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7.0 |
| google | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the Cloud Storage bucket (must be globally unique). | `string` | n/a | yes |
| force_destroy | Enables deletion of the bucket even if it contains objects. | `bool` | `false` | no |
| labels | Labels applied to the bucket. | `map(string)` | `{}` | no |
| project | GCP Project ID where the bucket will be created. | `string` | n/a | yes |
| region | GCP region where the bucket will be deployed. | `string` | n/a | yes |
| storage_class | Bucket storage class (STANDARD, NEARLINE, COLDLINE, ARCHIVE). | `string` | `"STANDARD"` | no |
| versioning_enabled | Enables object versioning for the bucket. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_name | Name of the Cloud Storage bucket. |
| bucket_self_link | Self-link URI of the bucket resource. |
| bucket_url | gs:// URL of the bucket. |
<!-- END_TF_DOCS -->
