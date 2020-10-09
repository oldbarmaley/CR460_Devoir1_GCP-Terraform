# une instance nommée "fermier"
#de type "f1-micro"
#Ubuntu 20.04
#cible "fermier"
#dans le réseau par défaut de votre projet
############################################################################
resource "google_compute_instance" "instance1" {
  name         = "fermier"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  #  zone         = var.zone
  tags = ["fermier"]


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = data.google_compute_network.devoir1.name
    subnetwork = google_compute_subnetwork.fermier.name
    access_config {
      // Ephemeral IP
    }
  }
}
###############################################################################
#une instance nommée "canard"
#de type "f1-micro"
#debian-9
#avec une adresse ip publique
#dans le sous-réseau "prod-dmz"
#avec un serveur apache2 à jour
#  * _le serveur doit être accessible publiquement_
resource "google_compute_instance" "instance2" {
  name         = "canard"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  #  zone         = var.zone
  tags = ["web-public"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-dmz.name
    access_config {
    }
  }

  metadata_startup_script = "sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y install apache2 && sudo systemctl start apache2"
}
###############################################################################
#une instance nommée "mouton"*
#de type "f1-micro"
#CoreOs
#cible "interne"
#dans le sous-réseau "prod-interne"
#  * _cette instance doit être accessible publiquement par ssh_
#  * cette instance doit pouvoir recevoir du  trafic TCP sur les ports "2846", "5462", seulement à partir du sous-réseau "TRAITEMENT"
resource "google_compute_instance" "instance3" {
  name         = "mouton"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  #  zone         = var.zone
  tags = ["interne"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-interne.name
    access_config {
    }
  }
}

###############################################################################
#une instance nommée "cheval"
#de type "f1-micro"
#CoreOs
#cible "traitement"
#dans le sous-réseau "prod-traitement"
resource "google_compute_instance" "instance4" {
  name         = "cheval"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  #  zone         = var.zone
  tags = ["traitement"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-traitement.name
    access_config {
    }
  }
}
