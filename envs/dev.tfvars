# Environnement DEV : stockage standard, bucket jetable, rétention courte.

project_name = "corvexa"
environment  = "dev"
gcp_region   = "europe-west1"

storage_class             = "STANDARD"
bucket_force_destroy      = true
bucket_versioning_enabled = false

pubsub_message_retention_duration = "3600s"
pubsub_ack_deadline_seconds       = 20

labels = {
  owner = "aliou"
  cours = "cloud-floci-terraform"
}
