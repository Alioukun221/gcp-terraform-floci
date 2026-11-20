variable "project_name" {
  type        = string
  description = "Short product name used as a prefix for all resources."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,20}$", var.project_name))
    error_message = "project_name must start with a lowercase letter and contain only lowercase letters, digits, and hyphens (2 to 21 characters)."
  }
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev or prod)."

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be either \"dev\" or \"prod\"."
  }
}

variable "gcp_project" {
  type        = string
  description = "GCP Project ID (fixed for Floci-GCP: floci-local)."
  default     = "floci-local"
}

variable "gcp_region" {
  type        = string
  description = "GCP region (emulated by Floci-GCP, must be a valid GCP region identifier)."
  default     = "europe-west1"

  validation {
    condition = contains([
      "europe-west1", "europe-west9", "us-central1", "us-east1"
    ], var.gcp_region)
    error_message = "gcp_region must be one of the allowed regions: europe-west1, europe-west9, us-central1, us-east1."
  }
}

variable "floci_gcp_host" {
  type        = string
  description = "Local Floci-GCP endpoint (host:port) used by the google provider."
  default     = "localhost:4588"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]+:[0-9]+$", var.floci_gcp_host))
    error_message = "floci_gcp_host must follow host:port format, e.g. localhost:4588."
  }
}

variable "labels" {
  type        = map(string)
  description = "Common labels applied to all resources (lowercase keys and values as required by GCP)."
  default     = {}

  validation {
    condition = alltrue([
      for k, v in var.labels : can(regex("^[a-z][a-z0-9_-]{0,62}$", k)) && can(regex("^[a-z0-9_-]{0,63}$", v))
    ])
    error_message = "All label keys and values must consist only of lowercase letters, digits, hyphens, or underscores (GCP requirement)."
  }
}

variable "storage_class" {
  type        = string
  description = "Storage class for the GCS bucket (STANDARD, NEARLINE, COLDLINE, ARCHIVE)."
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "storage_class must be one of the valid GCP storage classes: STANDARD, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable "bucket_force_destroy" {
  type        = bool
  description = "Allows terraform destroy to remove the bucket even if it contains objects."
  default     = true
}

variable "bucket_versioning_enabled" {
  type        = bool
  description = "Enables object versioning on the GCS bucket."
  default     = false
}

variable "pubsub_message_retention_duration" {
  type        = string
  description = "Retention duration for unacknowledged messages (Duration format, e.g. 86400s)."
  default     = "86400s"

  validation {
    condition     = can(regex("^[0-9]+s$", var.pubsub_message_retention_duration))
    error_message = "pubsub_message_retention_duration must be in \"<seconds>s\" format, e.g. \"86400s\"."
  }

  validation {
    condition     = tonumber(trimsuffix(var.pubsub_message_retention_duration, "s")) >= 600 && tonumber(trimsuffix(var.pubsub_message_retention_duration, "s")) <= 604800
    error_message = "pubsub_message_retention_duration must be between 600s (10 min) and 604800s (7 days) as enforced by Pub/Sub."
  }
}

variable "pubsub_ack_deadline_seconds" {
  type        = number
  description = "Acknowledgment deadline for subscription messages (seconds)."
  default     = 20

  validation {
    condition     = var.pubsub_ack_deadline_seconds >= 10 && var.pubsub_ack_deadline_seconds <= 600
    error_message = "pubsub_ack_deadline_seconds must be between 10 and 600 as enforced by Pub/Sub."
  }
}
