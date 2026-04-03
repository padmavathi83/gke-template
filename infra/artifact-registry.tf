module "gar" {
  source  = "GoogleCloudPlatform/artifact-registry/google"
  version = "~> 0.8"

  project_id    = var.project_id
  location      = var.region
  format        = "DOCKER"
  repository_id = "bnsf-artifact-repo1"

  labels = var.labels
}
