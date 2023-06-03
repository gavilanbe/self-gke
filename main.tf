provider "google" {
  credentials = file("<YOUR CREDENTIALS JSON FILE>")
  project     = "<YOUR PROJECT ID>"
  region      = "<YOUR REGION>"
}

# K8s MASTER

resource "google_compute_instance_template" "k8s-master" {
  name_prefix  = "k8s-master-template-"
  machine_type = "n1-standard-1"
  region       = "<YOUR_REGION>"

  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "k8s-master" {
  name        = "k8s-master"
  base_instance_name = "k8s-master"
  zone        = "<YOUR_ZONE>"
  version {
    instance_template = google_compute_instance_template.k8s-master.id
  }

  target_size = 1
}


# K8s WORKER

resource "google_compute_instance_template" "k8s-worker" {
  name_prefix  = "k8s-worker-template-"
  machine_type = "n1-standard-1"
  region       = "<YOUR_REGION>"

  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "k8s-worker" {
  name        = "k8s-worker"
  base_instance_name = "k8s-worker"
  zone        = "<YOUR_ZONE>"
  version {
    instance_template = google_compute_instance_template.k8s-worker.id
  }

  target_size = 3
}
