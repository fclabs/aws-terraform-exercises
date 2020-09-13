#########################################################A
### SECRETS

variable "aws_access_key" { type = string }
variable "aws_secret_key" { type = string }
variable "aws_key_pair_pub" { type = string }
variable "local_key_pair_priv" { type = string }
variable "db_master_password" { type = string }
variable "db_master_user" { type = string }
### Define Secret valies in secrets.auto.tfvars (not included in git repo)
#########################################################A

variable "db_database" { type = string }
variable "db_name" { type = string }

variable "instance_ami" { type = string }
variable "instance_ami_name" { type = string }
variable "instance_name" { type = string }


provider "aws" {
    access_key = var.aws_access_key 
    secret_key = var.aws_secret_key 
    region     = "us-east-1"
}

## Network definitions
variable "vpc_cidr" { 
  default = "192.168.0.0/16" 
}

variable "vpc_networks" {
    default = [
      {
          name = "Public-east-1a"
          az = "us-east-1a"
          public = true
          cidr_network = "192.168.1.0/24"
      },
      {
          name = "Private-east-1a"
          az = "us-east-1a"
          public = false
          cidr_network = "192.168.3.0/24"
      },

  ]
}