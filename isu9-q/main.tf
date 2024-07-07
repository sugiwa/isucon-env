terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("~/gcp/pem/terraform-user.json")

  project = "terraform-project-425615"
  region  = var.region
  zone    = var.zone
}

module "app" {
  source = "./modules/app"

  zone       = var.zone
  network_id = google_compute_network.this.id
  subnet_id  = google_compute_subnetwork.public_subnet_1.id

  image        = "ubuntu-os-cloud/ubuntu-2004-lts"
  machine_type = "c2-standard-4"
  disk_size    = 20
  setup_script = "./scripts/setup_app.sh"
}