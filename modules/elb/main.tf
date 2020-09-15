### 
# The module creates an ELB and add the listernes or the target groups if they are specified

## Define the LB to use
# create resource if that is required
resource "aws_lb" "new" {
    count = var.lb_create ? 1 : 0

    name = var.lb_name
    internal = var.lb_internal 

    load_balancer_type = var.lb_type 
    ip_address_type = var.lb_ip_address_type 
   
    security_groups = var.lb_security_groups 
    subnets = var.lb_subnets

    tags = {
        Name = var.lb_name
    }
}
# Search the ELB if that is required
data "aws_lb" "old" {
    count = (! var.lb_create) ? 1 : 0
    
    name = var.lb_name
}
locals {
    lb = var.lb_create ? aws_lb.new[0] : data.aws_lb.old[0]
}

# For each target group, creates a target group and listener in the same port and protocol
resource "aws_lb_target_group" "tg" {
    count = length( var.lb_target_groups )

    name = lookup( var.lb_target_groups[ count.index ] , "name" )
    port = lookup( var.lb_target_groups[ count.index ] , "port" )
    protocol = lookup( var.lb_target_groups[ count.index ] , "protocol" )
    vpc_id = lookup( var.lb_target_groups[ count.index ] , "vpc_id" )
    target_type = "instance"

    tags = {
        Name = lookup( var.lb_target_groups[ count.index ] , "name" )
        LB = local.lb.name
    }

}
resource "aws_lb_listener" "list" {
    count = length( var.lb_target_groups )

    load_balancer_arn = local.lb.arn
    port = lookup( var.lb_target_groups[ count.index ] , "port" )
    protocol = lookup( var.lb_target_groups[ count.index ] , "protocol" )   

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tg[ count.index ].arn
    }
}

data "aws_lb_target_group" "tg_attach" {
    count = length( var.lb_target_group_attach )

    name = lookup( var.lb_target_group_attach[ count.index ] , "name" )
}

resource "aws_lb_target_group_attachment" "attach" {
    count = length( var.lb_target_group_attach )

    target_group_arn = data.aws_lb_target_group.tg_attach[ count.index ].arn
    target_id = lookup( var.lb_target_group_attach[ count.index ] , "target" )
}

