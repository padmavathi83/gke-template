module "gar" {
  source  = "GoogleCloudPlatform/artifact-registry/google"
  version = "~> 0.8"

  project_id    = var.project_id
  location      = var.region
  format        = "DOCKER"
  repository_id = "bnsf-artifact-repo"

  labels = var.labels
}