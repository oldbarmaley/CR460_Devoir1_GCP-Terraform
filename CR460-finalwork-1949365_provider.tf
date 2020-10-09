provider "google" {
  project     = var.project_id
  credentials = "cr460-2020-1949365-5094eddac755.json"
  region      = "us-east1"
  zone        = var.zone
  #zone        = "us-east1-c"
}
