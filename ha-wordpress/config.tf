#########################################################A
### SECRETS

variable "aws_access_key" { type = string }
variable "aws_secret_key" { type = string }
variable "aws_key_pair_pub" { type = string }
variable "local_key_pair_priv" { type = string }
variable "db_master_password" { type = string }
variable "db_master_user" { type = string }
variable "dns_zone" { type = string }

### Define Secret valies in secrets.auto.tfvars (not included in git repo)
#########################################################A

variable "aws_region"  { type = string }

variable "lab_name" { type = string }
variable "sg_name_websvr" { type = string }
variable "sg_name_lbfront" { type = string }

variable "bucket_name_media" { type = string }
variable "bucket_name_code" { type = string }
variable "iam_instance_profile_name" { type = string }

variable "cf_target_origin_id" { type = string }

variable "db_database" { type = string }
variable "db_name" { type = string }

variable "lb_name" { type = string }
variable "lb_target_group_name" { type = string }

variable "lc_name" { type = string }
variable "lc_image" { type = string }
variable "lc_instance_type" { type = string }

variable "autoscaling_group_name" { type = string }

provider "aws" {
    access_key = var.aws_access_key 
    secret_key = var.aws_secret_key 
    region     = var.aws_region
}

## VPC Network definitions
variable "vpc_cidr" { 
  default = "192.168.0.0/16" 
}

## VPC Subnets topology
variable "vpc_networks" {
    default = [
      {
          name = "Public-east-1a"
          az = "us-east-1a"
          public = true
          cidr_network = "192.168.1.0/24"
          has_db = false
      },
      {
          name = "Public-east-1b"
          az = "us-east-1b"
          public = true
          cidr_network = "192.168.2.0/24"
          has_db = false
      },
      {
          name = "Private-east-1a"
          az = "us-east-1a"
          public = false
          cidr_network = "192.168.3.0/24"
          has_db = true
      },
      {
          name = "Private-east-1b"
          az = "us-east-1b"
          public = false
          cidr_network = "192.168.4.0/24"
          has_db = true
      },
  ]
}



