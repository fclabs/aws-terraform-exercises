module "vpc_c" {
    source = "../../modules/vpc"

    vpc_name = "${var.lab_name}-Client"
    vpc_cidr  = var.vpc_cidr_client
    networks = var.vpc_networks_client
}
# output "vpc_subnet_privs" 
# List of private subnet ids 
# output "vpc_subnet_pubs" 
# List of public subnets ids
# output "id" 
# VPC id


module "vpc_v" {
    source = "../../modules/vpc"

    vpc_name = "${var.lab_name}-Vault"
    vpc_cidr  = var.vpc_cidr_vault
    networks = var.vpc_networks_vault
}
# output "vpc_subnet_privs" 
# List of private subnet ids 
# output "vpc_subnet_pubs" 
# List of public subnets ids
# output "id" 
# VPC id

# Create a Security Group for the Web Instance
module sgweb_vault_create {
    source = "../../modules/security_group"

    name = var.sg_name_websvr_vault
    vpc_id = module.vpc_v.id
}

# Create a Security Group for the Web Instance
module sgweb_client_create {
    source = "../../modules/security_group"

    name = var.sg_name_websvr_client
    vpc_id = module.vpc_c.id
}

