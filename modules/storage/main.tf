resource "google_storage_bucket" "this" {
  name          = var.bucket_name
  project       = var.project
  location      = var.region
  storage_class = var.storage_class
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true

  versioning {
    enabled = var.versioning_enabled
  }

  labels = var.labels
}
