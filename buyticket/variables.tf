variable "region" {
  type = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "profile" {
  type = string
  description = "AWS Profile to map credentials"
}

variable "environment" {
  type = string
  validation {
    error_message = "environment must be either production, qa or staging"
    condition = contains([
      "production", "development", "staging"
    ], var.environment)
  }
}

variable "app_name" {
  type = string
}

locals {
  s3_origin_id = "S3-${aws_s3_bucket.spa_bucket.id}"
}