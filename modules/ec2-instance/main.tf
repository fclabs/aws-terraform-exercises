
# Search subnet resource to extract VPC id
data "aws_subnet" "sn" {
    id = var.instance_subnet
}

# Create an empty securoty group no SG was defined
resource "aws_security_group" "sg" {
    count = var.instance_security_group == null ? 1 : 0

    vpc_id = data.aws_subnet.sn.vpc_id 
    name = var.instance_name 
}

locals {
    instance_sg = var.instance_security_group == null ? aws_security_group.sg[0].id : var.instance_security_group
}

resource "aws_instance" "i" {
    ami = var.instance_ami
    
    subnet_id = var.instance_subnet
    instance_type = var.instance_type

    user_data = var.instance_user_data

    vpc_security_group_ids = [ local.instance_sg ]

    tags = {
        Name = var.instance_name 
    }
}