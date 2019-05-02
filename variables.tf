variable "account-name" {
  description = "The account shortname in which the vpc is to be deployed"
}
variable "aws_region" {
  description = "The AWS Region to operate in"
  default = "ap-southeast-2"
}
variable "vpc_cidr" {
  description = "The main VPC CIDR range"
}
variable "public_cidrs" {
  description = "A list of CIDR ranges for use in public subnets"
  type        = "list"
}
variable "private_cidrs" {
  description = "A list of CIDR ranges for use in private subnets"
  type        = "list"
}
variable "data_cidrs" {
  description = "A list of CIDR ranges for use in data subnets"
  type        = "list"
}
variable "nat_gateway" {
  description = "whether or not to deploy nat gateway"
  default     = 0
}
