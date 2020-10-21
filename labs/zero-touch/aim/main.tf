

## Create the network environment
locals {
    ami_vpc_cidr = "192.168.0.0/24"
    ami_vpc_networks = [
        {
            name = "Public-east-1a"
            az = "us-east-1a"
            public = false
            cidr_network = "192.168.0.0/25"
            has_db = false
        }
    ]
}
module "vpc" {
    source = "../../modules/vpc"

    vpc_name = "${var.lab_name}-AMI-Sandbox"
    vpc_cidr  = local.ami_vpc_cidr
    networks = local.ami_vpc_networks 
}
## Search for Default VPC SG
data "aws_security_group" "default" {
    vpc_id = module.vpc.id
}
## Search last ami in region
data "aws_ami" "aws_linux_2" {
    most_recent = true

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    owners           = ["amazon"]
}

## Create instance
locals {
    instance_name = "${var.lab_name}-AMI-Instance-Source"
    instance_user_data = <<EOD
#!/bin/bash
yum install -y git 
curl ${var.terraform_download_url} -o terraform.zip
unzip terraform.zip -d /usr/bin
EOD
}
data "aws_subnet" "svr" {
    vpc_id = module.vpc.id
    cidr_block = "192.168.0.0/25"

    depends_on = [
        module.vpc
    ]
}
resource "aws_instance" "ami_source" {
    ami = data.aws_ami.aws_linux_2.id
    
    subnet_id = data.aws_subnet.svr.id
    instance_type = var.instance_type

    user_data = local.instance_user_data
}
####

## Create AMI outside of terraform, so it is not destroyed when the 
## resources used to create it are destroyed.
resource "null_resource" "stop-instance" {
    provisioner "local-exec" {
        command = "aws ec2 create-image --name ${var.ami_name} --instance-id ${aws_instance.ami_source.id}"
    }
}


