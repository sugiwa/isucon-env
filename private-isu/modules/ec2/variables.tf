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