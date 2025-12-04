variable "ec2_count" {
  default = "1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {
 description = "The ID of the subnet where EC2 instances will be launched."
 type        = string
}
