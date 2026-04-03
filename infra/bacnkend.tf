terraform {
  backend "gcs" {
    bucket  = "mybucket-87357489"
    prefix  = "gke-template/state"
  }
}
