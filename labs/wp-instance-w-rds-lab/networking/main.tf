module "vpc" {
    source = "../../modules/vpc"

    vpc_name = var.lab_name
    vpc_cidr  = var.vpc_cidr
    networks = var.vpc_networks 
}
# output "vpc_subnet_privs" 
# List of private subnet ids 
# output "vpc_subnet_pubs" 
# List of public subnets ids
# output "id" 
# VPC id

# Create a Security Group for the Web Instance
module sgweb_create {
    source = "../../modules/security_group"

    name = var.sg_name_websvr
    vpc_id = module.vpc.id
}



