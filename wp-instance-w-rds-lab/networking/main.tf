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

# Add SSH ingress rule for Web Server Instance
module sgweb_add_ssh {
    source = "../../modules/security_group"

    id = module.sgweb_create.security_group_id

    operation = "add_cidr"

    type = "ingress"
    from = "0.0.0.0/0"
    from_port = 22
    to_port = 22
    protocol = "tcp"
}
# Add egress rule for Web Server Instance
module sgweb_add_egress_all {
    source = "../../modules/security_group"

    id = module.sgweb_create.security_group_id

    operation = "add_cidr"

    type = "egress"
    from = "0.0.0.0/0"
    from_port = 0
    to_port = 0
    protocol = "-1"
}

