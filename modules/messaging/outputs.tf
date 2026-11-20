output "topic_id" {
  description = "Full ID of the Pub/Sub topic."
  value       = google_pubsub_topic.this.id
}

output "topic_name" {
  description = "Name of the Pub/Sub topic."
  value       = google_pubsub_topic.this.name
}

output "subscription_id" {
  description = "Full ID of the Pub/Sub subscription."
  value       = google_pubsub_subscription.this.id
}

output "subscription_name" {
  description = "Name of the Pub/Sub subscription."
  value       = google_pubsub_subscription.this.name
}
