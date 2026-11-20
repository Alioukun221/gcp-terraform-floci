# Messaging Module

Creates a Pub/Sub topic and an associated processing subscription, with validated
variables enforcing strict Pub/Sub constraints (retention 600s–604800s, ack deadline 10–600s).

Documentation generated with [terraform-docs](https://terraform-docs.io):

```bash
terraform-docs markdown table --output-file README.md --output-mode inject modules/messaging
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
| [google_pubsub_subscription.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_topic.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ack_deadline_seconds | Acknowledgment deadline for subscription messages (seconds). | `number` | `20` | no |
| labels | Labels applied to the topic and subscription. | `map(string)` | `{}` | no |
| message_retention_duration | Retention duration for unacknowledged messages (Duration format, e.g. 86400s). | `string` | `"86400s"` | no |
| project | GCP Project ID where the topic and subscription will be created. | `string` | n/a | yes |
| subscription_name | Name of the Pub/Sub subscription attached to the topic. | `string` | n/a | yes |
| topic_name | Name of the Pub/Sub topic. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| subscription_id | Full ID of the Pub/Sub subscription. |
| subscription_name | Name of the Pub/Sub subscription. |
| topic_id | Full ID of the Pub/Sub topic. |
| topic_name | Name of the Pub/Sub topic. |
<!-- END_TF_DOCS -->
