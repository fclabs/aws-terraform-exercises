

resource "aws_security_group" sg {
    count = var.operation == "create" ? 1 : 0 

    name = var.name
    vpc_id = var.vpc_id
}


locals {
    sg_id = var.id == null ? aws_security_group.sg[0].id : var.id
}

resource "aws_security_group_rule" "add_cidr" {
    count = var.operation == "add_cidr" ? 1 : 0

    type = var.type
    security_group_id = var.id
    cidr_blocks = [ var.from ]
    from_port = var.from_port
    to_port = var.to_port
    protocol = var.protocol
}

resource "aws_security_group_rule" "add_source_sg" {
    count = var.operation == "add_source_sg" ? 1 : 0

    type = var.type
    security_group_id = var.id
    source_security_group_id = var.from 
    from_port = var.from_port
    to_port = var.to_port
    protocol = var.protocol
}

