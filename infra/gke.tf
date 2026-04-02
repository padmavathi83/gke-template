data "google_client_config" "default" {}

data "google_project" "project" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 43.0"

  project_id                  = var.project_id
  name                        = "${var.environment}-gke-cluster"
  regional                    = true
  region                      = var.region
  zones                       = var.zones
  network                     = module.gcp_network.network_name
  subnetwork                  = module.gcp_network.subnets_names[0]
  network_policy              = true
  ip_range_pods               = "ip-range-pods"
  ip_range_services           = "ip-range-services"
  create_service_account      = true
  service_account_name        = var.service_account_name
  enable_private_endpoint     = false
  enable_private_nodes        = true
  enable_secret_manager_addon = true
  enable_intranode_visibility = true
  #   enable_binary_authorization = true
  #   node_metadata             = "GKE_METADATA_SERVER"
  default_max_pods_per_node = var.gke_default_max_pods_per_node
  remove_default_node_pool  = true
  deletion_protection       = false
  enable_k8s_beta_apis      = var.enable_k8s_beta_apis

  node_pools = [
    {
      name            = "pool-01"
      min_count       = 1
      max_count       = 2
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"
      machine_type    = var.gke_node_pool_machine_type
      auto_repair     = true
      auto_upgrade    = true
      # service_account    = var.service_account_name.email
      preemptible        = false
      enable_secure_boot = true
      max_pods_per_node = 12
    },
  ]

  #   master_authorized_networks = [
  #     {
  #       cidr_block   = module.gcp_network.subnets_ips[0]
  #       display_name = "VPC"
  #     },
  #     {
  #       cidr_block   = "67.164.183.237/32"
  #       display_name = "Aaron"
  #     },
  #   ]

  cluster_resource_labels = var.labels
}

resource "google_project_iam_member" "gke_sa_artifact_registry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${module.gke.service_account}"
}

resource "google_project_iam_member" "gke_sa_secret_manager_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.project_id}.svc.id.goog/subject/ns/${var.k8s_namespace}/sa/default"
}

