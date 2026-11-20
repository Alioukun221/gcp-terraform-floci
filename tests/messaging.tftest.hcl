# Tests unitaires du module messaging, exécutés en mode "plan" uniquement
# contre un provider google MOCKÉ (aucun appel réseau, aucune dépendance à
# Floci-GCP) : terraform test tests/messaging.tftest.hcl

mock_provider "google" {}

variables {
  topic_name        = "corvexa-dev-order-events"
  subscription_name = "corvexa-dev-order-events-worker"
  project           = "floci-local"
}

run "default_retention_and_ack_deadline" {
  command = plan

  module {
    source = "./modules/messaging"
  }

  assert {
    condition     = google_pubsub_topic.this.message_retention_duration == "86400s"
    error_message = "La rétention par défaut doit être 86400s."
  }

  assert {
    condition     = google_pubsub_subscription.this.ack_deadline_seconds == 20
    error_message = "Le délai d'acquittement par défaut doit être 20s."
  }

  assert {
    condition     = google_pubsub_subscription.this.topic == google_pubsub_topic.this.name
    error_message = "La subscription doit être attachée au topic créé par ce module."
  }
}

run "prod_profile_uses_max_retention" {
  command = plan

  variables {
    message_retention_duration = "604800s"
    ack_deadline_seconds       = 60
  }

  module {
    source = "./modules/messaging"
  }

  assert {
    condition     = google_pubsub_topic.this.message_retention_duration == "604800s"
    error_message = "Le profil prod doit utiliser la rétention maximale (7 jours)."
  }
}

run "rejects_ack_deadline_out_of_range" {
  command = plan

  variables {
    ack_deadline_seconds = 5000
  }

  module {
    source = "./modules/messaging"
  }

  expect_failures = [
    var.ack_deadline_seconds,
  ]
}

run "rejects_malformed_retention_duration" {
  command = plan

  variables {
    message_retention_duration = "1day"
  }

  module {
    source = "./modules/messaging"
  }

  expect_failures = [
    var.message_retention_duration,
  ]
}
