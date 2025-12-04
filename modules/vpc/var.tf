variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
  default = "dedicated"
}

variable "vpc_id" {
  description = "The ID of the existing VPC."
  type        = string
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "env" {
  description = "The environment on which to spin infra"
  type        = string
}
