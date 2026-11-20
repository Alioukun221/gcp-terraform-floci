# Suffix required for global uniqueness of GCS bucket names.
resource "random_id" "suffix" {
  byte_length = 3
}

module "storage" {
  source = "./modules/storage"

  bucket_name = "${local.bucket_name_base}-media-archive-${random_id.suffix.hex}"
  project     = var.gcp_project
  region      = var.gcp_region

  storage_class      = var.storage_class
  force_destroy      = var.bucket_force_destroy
  versioning_enabled = var.bucket_versioning_enabled

  labels = local.common_labels
}

module "messaging" {
  source = "./modules/messaging"

  topic_name        = "${local.resource_prefix}-order-events"
  subscription_name = "${local.resource_prefix}-order-events-worker"
  project           = var.gcp_project

  message_retention_duration = var.pubsub_message_retention_duration
  ack_deadline_seconds       = var.pubsub_ack_deadline_seconds

  labels = local.common_labels
}
