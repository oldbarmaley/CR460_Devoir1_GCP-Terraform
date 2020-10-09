data "google_compute_network" "devoir1" {
  name    = "devoir1"
  project = data.google_project.default-project.project_id
}

data "google_project" "default-project" {
  project_id = var.project_id
}
