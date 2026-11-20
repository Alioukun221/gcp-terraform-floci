resource "google_pubsub_topic" "this" {
  name    = var.topic_name
  project = var.project

  message_retention_duration = var.message_retention_duration

  labels = var.labels
}

resource "google_pubsub_subscription" "this" {
  name    = var.subscription_name
  project = var.project
  topic   = google_pubsub_topic.this.name

  ack_deadline_seconds = var.ack_deadline_seconds

  labels = var.labels
}
