variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources to"
  type        = string
  default     = "us-central1"
}

variable "zones" {
  description = "The zones to deploy resources to"
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"]
}

variable "tf_state_bucket_name" {
  description = "The name of the GCS bucket to store Terraform state (must be globally unique)"
  type        = string
}

variable "enable_k8s_beta_apis" {
  description = "Description: (Optional) - List of Kubernetes Beta APIs to enable in cluster."
  type        = list(string)
  default     = []
}

variable "service_account_name" {
  description = "The name of the service account to be used by GKE nodes"
  type        = string
}

variable "subdomain_prefix" {
  description = "Prefix for the subdomain based on the environment (e.g. dev = dev., prod = (empty), non-prod = np.)"
  type        = string
  default     = ""
}

variable "gke_node_pool_machine_type" {
  description = "The machine type to use for GKE node pools"
  type        = string
  default     = "e2-standard-2"
}

variable "gke_default_max_pods_per_node" {
  description = "The default maximum number of pods per node in GKE"
  type        = number
  default     = 20
}

variable "k8s_namespace" {
  description = "The Kubernetes namespace to use"
  type        = string
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

variable "labels" {
  description = "Labels to apply to resources"
  type        = map(string)
  default     = {}
}
variable "environment" {
  description = "The environment name (e.g. dev, prod)"
  type        = string
  default     = "dev"
}
