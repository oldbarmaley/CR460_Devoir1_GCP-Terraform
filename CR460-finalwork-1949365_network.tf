resource "google_compute_network" "devoir1" {
  name                    = "devoir1"
  auto_create_subnetworks = "false"
}

#############################
resource "google_compute_subnetwork" "fermier" {
  name          = "devoir1"
  ip_cidr_range = "192.168.1.0/24"
  network       = google_compute_network.devoir1.self_link
  region        = "us-east1"
}
#############################
resource "google_compute_subnetwork" "prod-dmz" {
  name          = "prod-dmz"
  ip_cidr_range = "172.16.3.0/24"
  network       = google_compute_network.devoir1.self_link
  region        = "us-east1"
}
################################
resource "google_compute_subnetwork" "prod-interne" {
  name          = "prod-interne"
  ip_cidr_range = "10.0.3.0/24"
  network       = google_compute_network.devoir1.self_link
  region        = "us-east1"
}
###############################
resource "google_compute_subnetwork" "prod-traitement" {
  name          = "prod-traitement"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.devoir1.self_link
  region        = "us-east1"
}
#################################
resource "google_compute_firewall" "web_public" {
  name    = "web-public"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  target_tags = ["web-public"]
}

resource "google_compute_firewall" "ssh_default" {
  name    = "ssh-fermier"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["fermier"]
}

resource "google_compute_firewall" "ssh_public" {
  name    = "ssh-public"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["interne", "web-public", "traitement"]
}


resource "google_compute_firewall" "traitement-tcp" {
  name    = "traitement-tcp"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports    = ["2846", "5462"]
  }
  source_ranges = ["10.0.2.0/24"]
  target_tags   = ["interne"]
}
