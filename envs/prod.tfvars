# Environnement PROD : stockage économique (NEARLINE), bucket protégé,
# versioning actif, rétention longue.

project_name = "corvexa"
environment  = "prod"
gcp_region   = "europe-west1"

storage_class             = "NEARLINE"
bucket_force_destroy      = false
bucket_versioning_enabled = true

pubsub_message_retention_duration = "604800s"
pubsub_ack_deadline_seconds       = 60

labels = {
  owner = "aliou"
  cours = "cloud-floci-terraform"
}
