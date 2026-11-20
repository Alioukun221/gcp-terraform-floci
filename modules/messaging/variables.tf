variable "topic_name" {
  type        = string
  description = "Name of the Pub/Sub topic."

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_.~+-]{2,254}$", var.topic_name))
    error_message = "topic_name must start with a letter and contain between 3 and 255 valid Pub/Sub characters."
  }
}

variable "subscription_name" {
  type        = string
  description = "Name of the Pub/Sub subscription attached to the topic."

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_.~+-]{2,254}$", var.subscription_name))
    error_message = "subscription_name must start with a letter and contain between 3 and 255 valid Pub/Sub characters."
  }
}

variable "project" {
  type        = string
  description = "GCP Project ID where the topic and subscription will be created."
}

variable "message_retention_duration" {
  type        = string
  description = "Retention duration for unacknowledged messages (Duration format, e.g. 86400s)."
  default     = "86400s"

  validation {
    condition     = can(regex("^[0-9]+s$", var.message_retention_duration))
    error_message = "message_retention_duration must be in \"<seconds>s\" format, e.g. \"86400s\"."
  }
}

variable "ack_deadline_seconds" {
  type        = number
  description = "Acknowledgment deadline for subscription messages (seconds)."
  default     = 20

  validation {
    condition     = var.ack_deadline_seconds >= 10 && var.ack_deadline_seconds <= 600
    error_message = "ack_deadline_seconds must be between 10 and 600 as enforced by Pub/Sub."
  }
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to the topic and subscription."
  default     = {}
}
