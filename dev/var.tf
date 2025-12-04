variable "env" {
  default = "prod"
}

variable "table_name" {
  default = "networknuts-iac-terraform-state-lock-dynamo-prod"
}

variable "bucket_name" {
  default = "networknuts-terraform-state-s3-prod"
}
