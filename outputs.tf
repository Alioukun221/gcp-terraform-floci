output "bucket_name" {
  description = "Name of the Cloud Storage bucket (Service 1)."
  value       = module.storage.bucket_name
}

output "bucket_url" {
  description = "gs:// URL of the bucket."
  value       = module.storage.bucket_url
}

output "topic_name" {
  description = "Name of the Pub/Sub topic (Service 2)."
  value       = module.messaging.topic_name
}

output "topic_id" {
  description = "Full ID of the Pub/Sub topic."
  value       = module.messaging.topic_id
}

output "subscription_name" {
  description = "Name of the Pub/Sub subscription."
  value       = module.messaging.subscription_name
}
