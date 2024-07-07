# VPC
resource "google_compute_network" "this" {
  name = "terraform-network"
}

# Public Subnet
resource "google_compute_subnetwork" "public_subnet_1" {
  name          = "terraform-public-subnet-1"
  network       = google_compute_network.this.id
  ip_cidr_range = "10.0.1.0/24"

}

resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.this.id
  priority      = 1000
  source_ranges = ["${chomp(data.http.ipv4_icanhazip.response_body)}/32"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "app" {
  name = "allow-app"
  allow {
    ports    = ["8000", "80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.this.id
  priority      = 1000
  source_ranges = ["${chomp(data.http.ipv4_icanhazip.response_body)}/32"]
  target_tags   = ["web"]
}

resource "google_compute_firewall" "netdata" {
  name = "allow-netdata"
  allow {
    ports    = ["19999"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.this.id
  priority      = 1000
  source_ranges = ["${chomp(data.http.ipv4_icanhazip.response_body)}/32"]
  target_tags   = ["web"]
}

data "http" "ipv4_icanhazip" {
  url = "https://ipv4.icanhazip.com/"
}