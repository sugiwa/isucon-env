# Compute Engine
resource "google_compute_instance" "this" {
  name = "terraform-instance"
  # machine_type = "e2-micro"
  machine_type              = var.machine_type
  allow_stopping_for_update = true
  zone                      = var.zone
  tags                      = ["ssh", "web"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnet_id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  metadata_startup_script = file(var.setup_script)

  metadata = {
    "ssh-keys" = "${var.username}:${tls_private_key.ssh_key.public_key_openssh}"
  }
}