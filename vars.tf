variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_az_1" {}
variable "aws_az_2" {}
variable "aws_az_3" {}

variable "aws_ec2_key_name" {}
variable "aws_ec2_key_path" {}
variable "aws_ec2_ami" {}
variable "aws_ec2_instance_type" {}
variable "aws_ec2_instance_name" {}
variable "aws_ec2_instance_count" {}
variable "aws_ec2_zones" {
  default = {
    "0" = "us-west-2a"
    "1" = "us-west-2b"
    "2" = "us-west-2c"
  }
}

variable "aws_nat_ami" {}

variable "aws_s3_bucket_name" {}

variable "aws_vpc_subnet_prefix" {}

variable "atlas" {}
variable "atlas_token" {}

variable "consul_datacenter_name" {}

# comma separated string, where restricted access is required,
# for example: ssh, these are the cidr blocks that will be used
# NO SPACES are allowed after the commas
variable "restricted_access_cidr_blocks" {
  description = "Comma separated string of cidr blocks to use where restricted access is required, for example: ssh. NO SPACES are allowed after the commas"
}