variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
  default = "project-eb9a3368-5e31-47ac-837"
}

variable "region" {
  description = "The region to deploy resources to"
  type        = string
  default     = "us-central1"
}
variable "subnet_ip" {
  description = "The IP range for the subnet"
  type        = string
}
variable "secondary_ranges_pods_ip" {
  description = "IP range for GKE Pods secondary range"
  type        = string
}

variable "secondary_ranges_services_ip" {
  description = "IP range for GKE Services secondary range"
  type        = string
}
variable "environment" {
  description = "The environment name (e.g. dev, prod)"
  type        = string
  default     = "dev"
}
