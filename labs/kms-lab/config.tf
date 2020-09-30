#########################################################A
### SECRETS SHARES in ALL LABS

variable "aws_access_key" { type = string }
variable "aws_secret_key" { type = string }
variable "aws_key_pair_pub" { type = string }
variable "local_key_pair_priv" { type = string }

variable "dns_zone" { type = string }

### This Lab secrets
variable "aws_account_id" { type = string }
variable "aws_admin_users" { type = list(string) }



### Define Secret valies in secrets.auto.tfvars (not included in git repo)
#########################################################A

variable "lab_name" { type = string }
variable "aws_region" { type = string }
variable "sg_name_websvr_vault" { type = string }
variable "sg_name_websvr_client" { type = string }

variable "instance_ami" { type = string }
variable "instance_name_vault" { type = string }
variable "instance_name_client" { type = string }
variable "key_pair_name" { type = string }

variable "iam_instance_profile_name" { type = string }

provider "aws" {
    access_key = var.aws_access_key 
    secret_key = var.aws_secret_key 
    region     = var.aws_region
    version = "~> 3.6"
}

## Network definitions
variable "vpc_cidr_vault" { 
  default = "192.168.0.0/23" 
}
variable "vpc_cidr_client" { 
  default = "192.168.2.0/23" 
}
variable "server_subnet_cidr_vault" {
  default = "192.168.0.0/24" 
}
variable "server_subnet_cidr_client" {
  default = "192.168.2.0/24" 
}
variable "vpc_networks_vault" {
    default = [
      {
          name = "Public-east-1a"
          az = "us-east-1a"
          public = true
          cidr_network = "192.168.0.0/24"
      }
  ]
}
variable "vpc_networks_client" {
    default = [
      {
          name = "Public-east-1a"
          az = "us-east-1a"
          public = true
          cidr_network = "192.168.2.0/24"
      }
  ]
}
