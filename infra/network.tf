module "gcp_network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 13.0"

  project_id   = var.project_id
  network_name = "${var.environment}-vpc"

  subnets = [
    {
      subnet_name               = "${var.environment}-subnet"
      subnet_ip                 = var.subnet_ip
      subnet_region             = var.region
      subnet_private_access     = true
      subnet_flow_logs          = true
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.5
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    },
  ]

  secondary_ranges = {
    "${var.environment}-subnet" = [
      {
        range_name    = "ip-range-pods"
        ip_cidr_range = var.secondary_ranges_pods_ip
      },
      {
        range_name    = "ip-range-services"
        ip_cidr_range = var.secondary_ranges_services_ip
      },
    ]
  }
}