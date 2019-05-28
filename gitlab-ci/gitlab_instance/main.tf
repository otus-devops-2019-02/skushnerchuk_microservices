terraform {
  required_version = ">=0.11.7, <0.12"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "europe-west1"
}

resource "google_compute_instance" "gitlab" {
  name         = "gitlab"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  tags         = ["gitlab"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
      size  = 70
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.gitlab_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection = {
    type        = "ssh"
    # host        = "${google_compute_address.gitlab_ip.address}"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
  }

  provisioner "file" {
    source      = "files/install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "sudo chmod +x /tmp/install.sh",
      "/tmp/install.sh",
    ]
  }
}

resource "google_compute_address" "gitlab_ip" {
  name = "gitlab-ip"
}

resource "google_compute_firewall" "firewall_gitlab" {
  name    = "allow-gitlab-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22", "2222"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gitlab"]
}
