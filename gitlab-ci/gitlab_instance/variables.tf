variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable private_key_path {
  description = "Path to the private key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable project {
  description = "Project ID"
}

variable disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
