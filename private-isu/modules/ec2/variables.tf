variable "instance_name" {
  description = "instance name"
}
variable "ami" {
  description = "ami"
}

variable "instance_type" {
  description = "instance type"
}

variable "az" {
  description = "availability zone"
}

variable "tag_name" {
  description = "resource tag name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "instance_subnet_id" {
  type        = string
  description = "subnet for EC2 instance"
}

variable "ssh_key_name" {
  default = "ec2-keypair-v1"
}

variable "setup_script" {
  default = ""
}