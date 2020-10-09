output "canard_web_address_Apache2" {
  value = google_compute_instance.instance2.network_interface.0.access_config.0.nat_ip
}

output "instance1" {
  value = google_compute_instance.instance1.name
}

output "instance2" {
  value = google_compute_instance.instance2.name
}

output "instance3" {
  value = google_compute_instance.instance3.name
}

output "instance4" {
  value = google_compute_instance.instance4.name
}
