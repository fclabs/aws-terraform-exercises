
## Search VPC
data "aws_vpc" "vpc" {
    tags = {
        Name = var.lab_name
    }
}
## Search for Web Server Security Group
data "aws_security_group" "sg_svr" {
    name = var.sg_name_websvr
}

locals {
    db_subnets = [ for n in var.vpc_networks : n["cidr_network"] if n["has_db"] ]
}

data "aws_subnet" "db" {
    count = length( local.db_subnets )

    vpc_id = data.aws_vpc.vpc.id
    cidr_block = local.db_subnets[ count.index ]
}

### Create RDS instance
module "rds" {
    source = "../../modules/rds"

    db_master_user = var.db_master_user
    db_master_password = var.db_master_password
    db_database = var.db_database
    db_name = var.db_name
    db_subnets = data.aws_subnet.db[*].id
    db_vpc = data.aws_vpc.vpc.id
    db_multi_az = false
}
# output "db_security_group" 
# RDS Security group
# output "db_endpoint"
# FQDN:port to use to connect to database



# Add MYSQL access from WebSvr security group to RDS instance
module sgrds_add_mysql {
    source = "../../modules/security_group"

    id = module.rds.db_security_group

    operation = "add_source_sg"

    type = "ingress"
    from = data.aws_security_group.sg_svr.id
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
}

