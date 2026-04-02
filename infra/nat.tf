resource "google_compute_router" "nat_router" {
  name    = "${var.environment}-nat-router"
  network = module.gcp_network.network_name
  region  = var.region
  project = var.project_id

  depends_on = [module.gcp_network]
}

module "cloud_nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 7.0"
  project_id                         = var.project_id
  region                             = var.region
  router                             = google_compute_router.nat_router.name
  name                               = "${var.environment}-nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}