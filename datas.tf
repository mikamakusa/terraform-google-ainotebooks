data "google_project" "this" {
  project_id = var.project_id
}

data "google_compute_network" "this" {
  count = var.network_name ? 1 : 0
  name  = var.network_name
}

data "google_compute_subnetwork" "this" {
  count = var.subnetwork_name ? 1 : 0
  name  = var.subnetwork_name
}