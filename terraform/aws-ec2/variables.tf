variable "awscli_profile" {
  type        = string
  description = "AWS CLI profile to use"
}

variable "region" {
  type        = string
  description = "AWS region to use"
}

variable ami_name {
  type        = string
  description = "AWS AMI name to use"
}

# variable "ami" {
#  type        = string
#  description = "AWS AMI to use"
# }

variable "instance_type" {
  type        = string
  description = "AWS instance type to use"
}

variable "subnet_id" {
  type        = string
  description = "AWS subnet ID to use"
}

variable "key_name" {
  type        = string
  description = "AWS key pair to use"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID to use"
}

variable "tags" {
  type        = map(any)
  description = "AWS tags to apply to the resources"
  default     = {}
}

variable "security_group_ids" {
  type        = list(any)
  description = "AWS security group ids"
  default     = []
}

variable "private_key" {
 type        = string
 description = "Path to you local SSH private key (.pem)"
}

variable ec2_user {
  type        = string
  description = "The user to use for SSH"
  default     = "ec2-user"
}

variable ebs_volume_size {
  type        = number
  description = "The size of the EBS volume in GB"
  default     = 8
}