
resource "google_iam_workload_identity_pool" "github" {
  project                   = var.project_id
  workload_identity_pool_id = "github-pool"
  display_name              = "GitHub Actions Pool"
  description               = "Identity pool for GH Actions to access GCP resources"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub Actions Provider"
  description                        = "GitHub Actions identity pool provider"
  #   disabled                           = true
  attribute_condition = <<EOT
    assertion.repository_owner_id == "33541039" &&
    attribute.repository == "padmavathi83/gke-template"
EOT
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_project_iam_member" "github" {
  project = var.project_id
  role    = "roles/artifactregistry.createOnPushWriter"
  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/*"
}

resource "google_project_iam_member" "github_gke" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/*"
}

