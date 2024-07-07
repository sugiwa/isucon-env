variable "network_id" {
  description = "google_compute_network"
}

variable "subnet_id" {
  description = "google_compute_subnetwork"
}

variable "zone" {
  description = "zone"
}

variable "image" {}

variable "machine_type" {

}

variable "disk_size" {
  default = 8
  type    = number
}

variable "setup_script" {
}