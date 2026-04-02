terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }

  #   backend "gcs" {
  #     bucket = var.tf_state_bucket_name
  #     prefix = "dev"
  #   }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
