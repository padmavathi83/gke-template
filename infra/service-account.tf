resource "google_project_iam_member" "github_artifact" {
  project = var.project_id
  role    = "roles/artifactregistry.createOnPushWriter"
  member  = "serviceAccount:github-sa@project-eb9a3368-5e31-47ac-837.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "github_gke" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:github-sa@project-eb9a3368-5e31-47ac-837.iam.gserviceaccount.com"
}
