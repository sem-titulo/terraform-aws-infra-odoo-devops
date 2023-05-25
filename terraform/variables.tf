variable "project_name" {
  description = "Define what region the instance will be deployed"
}

variable "git_repository_branch" {
  description = "Define what region the instance will be deployed"
}

variable "git_repository_url" {
  description = "Define what region the instance will be deployed"
}

variable "git_token" {
  description = "Define what region the instance will be deployed"
}

variable "git_user" {
  description = "Define what region the instance will be deployed"
}

variable "region" {
  description = "Define what region the instance will be deployed"
}

variable "name" {
  description = "Name of the Application"
}

variable "env" {
  description = "Environment of the Application"
}

variable "ami" {
  description = "AWS AMI to be used "
  default     = "ami-07ebfd5b3428b6f4d"
}

variable "instance_type" {
  description = "AWS Instance type defines the hardware configuration of the machine"
}

variable "key_name" {
  description = "Aws access instances"
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}
variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = string
  default     = "Vpc-custom-demo"
}