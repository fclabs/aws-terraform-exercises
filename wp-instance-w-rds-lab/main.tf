module "vpc" {
    source = "../modules/vpc"

    vpc_name = "Lab-WP-HA"
    vpc_cidr  = var.vpc_cidr
    networks = var.vpc_networks 
}
# output "vpc_subnet_privs" 
# List of private subnet ids 
# output "vpc_subnet_pubs" 
# List of public subnets ids
# output "id" 
# VPC id


### Create RDS instance
# module "rds" {
#     source = "../modules/rds"

#     db_master_user = var.db_master_user
#     db_master_password = var.db_master_password
#     db_database = var.db_database
#     db_name = var.db_name
#     db_subnets = module.vpc.vpc_subnet_privs
#     db_vpc = module.vpc.id
# }
# output "db_security_group" 
# RDS Security group
# output "db_endpoint"
# FQDN:port to use to connect to database

locals {
    instance_ami = var.instance_ami
}

module "websvr" {
    source = "../modules/ec2-instance"

    instance_ami = local.instance_ami
    instance_name = var.instance_name
    instance_subnet = module.vpc.vpc_subnet_pubs[0]

}