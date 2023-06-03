provider "google" {
  credentials = file("<YOUR CREDENTIALS JSON FILE>")
  project     = "<YOUR PROJECT ID>"
  region      = "<YOUR REGION>"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "<YOUR ZONE>"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}