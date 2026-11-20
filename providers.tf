provider "google" {
  project = var.gcp_project
  region  = var.gcp_region

  # Floci-GCP does not validate real credentials; any non-empty token is accepted.
  access_token = "floci-local-token"

  storage_custom_endpoint = "http://${var.floci_gcp_host}/storage/v1/"
  pubsub_custom_endpoint  = "http://${var.floci_gcp_host}/v1/"
}
