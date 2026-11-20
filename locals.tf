locals {
  resource_prefix = "${var.project_name}-${var.environment}"

  # GCS bucket names: lowercase letters, digits, and hyphens only.
  bucket_name_base = substr(
    lower(replace(local.resource_prefix, "/[^a-z0-9-]/", "")),
    0, 40
  )

  common_labels = merge(var.labels, {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  })
}
