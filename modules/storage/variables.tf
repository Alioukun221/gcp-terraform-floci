variable "bucket_name" {
  type        = string
  description = "Name of the Cloud Storage bucket (must be globally unique)."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "bucket_name must be between 3 and 63 characters: lowercase letters, digits, hyphens, and cannot start or end with a hyphen."
  }
}

variable "project" {
  type        = string
  description = "GCP Project ID where the bucket will be created."
}

variable "region" {
  type        = string
  description = "GCP region where the bucket will be deployed."
}

variable "storage_class" {
  type        = string
  description = "Bucket storage class (STANDARD, NEARLINE, COLDLINE, ARCHIVE)."
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "storage_class must be one of the valid GCP classes: STANDARD, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable "force_destroy" {
  type        = bool
  description = "Enables deletion of the bucket even if it contains objects."
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "Enables object versioning for the bucket."
  default     = false
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to the bucket."
  default     = {}
}
