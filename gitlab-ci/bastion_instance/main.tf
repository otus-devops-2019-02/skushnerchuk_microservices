terraform {
  required_version = ">=0.11.7, <0.12"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "europe-west1"
}

resource "google_compute_instance" "gitlabrunner" {
  name         = "gitlabrunner"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  tags         = ["gitlab"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
      size  = 30
    }
  }

  network_interface {
    network = "default"

    access_config = {
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection = {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.gcp.yml create-bastion.yml"
  }

}

resource "google_compute_firewall" "firewall_gitlabrunner" {
  name    = "allow-gitlabrunner-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gitlabrunner"]
}
