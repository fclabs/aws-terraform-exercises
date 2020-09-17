### Search Resources
## Search VPC
data "aws_vpc" "vpc" {
    tags = {
        Name = var.lab_name
    }
}
## Search for Web Server Security Group
data "aws_security_group" "sg_lb" {
    name = var.sg_name_lbfront
}

# Search in network topolgy for public subnets
locals {
    lb_subnets = [ for n in var.vpc_networks : n["cidr_network"] if n["public"] ]
}

data "aws_subnet" "lb" {
    count = length( local.lb_subnets )

    vpc_id = data.aws_vpc.vpc.id
    cidr_block = local.lb_subnets[ count.index ]
}

# Add Web ingress rule for Web Server Instance
module sglb_add_http {
    source = "../../modules/security_group"

    id = data.aws_security_group.sg_lb.id

    operation = "add_cidr"

    type = "ingress"
    from = "0.0.0.0/0"
    from_port = 80
    to_port = 80
    protocol = "tcp"
}
# Add Egreee rule for Web Server Instance
module sglb_add_egress_all {
    source = "../../modules/security_group"

    id = data.aws_security_group.sg_lb.id

    operation = "add_cidr"

    type = "egress"
    from = "0.0.0.0/0"
    from_port = 0
    to_port = 0
    protocol = "-1"
}

module "lb_web_front"  {
    
    source = "../../modules/elb"
    
    lb_name = var.lb_name
    lb_create = true

    lb_security_groups = [ data.aws_security_group.sg_lb.id ]
    lb_subnets = data.aws_subnet.lb[*].id

    lb_target_groups = [
        {
            name = var.lb_target_group_name
            port = 80
            protocol = "HTTP"
            vpc_id = data.aws_vpc.vpc.id
        }
    ]
}
# output "elb_fqdn"
# ELB FQDN 

# Register the ELB FQDN as www record on DNS zone 
module "dns_record" {
    source = "../../modules/route53"

    zone = var.dns_zone
    records = [
        {
            name = "www"
            ttl = 60
            type = "CNAME"
            values = [ module.lb_web_front.elb_fqdn ]           
        }
    ]
}