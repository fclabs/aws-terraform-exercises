### Search resources
## Find running instance
## VPC
data "aws_vpc" "vpc" {
    tags = {
        Name = var.lab_name
    }
}
## Subnet that will hold de server
data "aws_subnet" "svr" {
    vpc_id = data.aws_vpc.vpc.id
    cidr_block = var.server_subnet_cidr
}
data "aws_instance" "i" {

    filter {
        name   = "subnet-id"
        values = [ data.aws_subnet.svr.id ]
    }

    filter {
        name   = "tag:Name"
        values = [ var.instance_name ]
    }
}

resource "aws_ami_from_instance" "wp-ami" {
    name               = "Wordpress AMI"
    source_instance_id = data.aws_instance.i.id
}
