
### Search for resources
## VPC
data "aws_vpc" "vpc" {
    tags = {
        Name = "${var.lab_name}-Client"
    }
}
## Search for Web Server Security Group
data "aws_security_group" "sg_svr" {
    name = var.sg_name_websvr_client
}

## Subnet that will hold de server
data "aws_subnet" "svr" {
    vpc_id = data.aws_vpc.vpc.id
    cidr_block = var.server_subnet_cidr_client
}

# Add SSH ingress rule for Web Server Instance
module sgweb_add_ssh {
    source = "../../modules/security_group"

    id = data.aws_security_group.sg_svr.id

    operation = "add_cidr"

    type = "ingress"
    from = "0.0.0.0/0"
    from_port = 22
    to_port = 22
    protocol = "tcp"
}
# Add Web ingress rule for Web Server Instance
module sgweb_add_http {
    source = "../../modules/security_group"

    id = data.aws_security_group.sg_svr.id

    operation = "add_cidr"

    type = "ingress"
    from = "0.0.0.0/0"
    from_port = 80
    to_port = 80
    protocol = "tcp"
}
# Add Egreee rule for Web Server Instance
module sgweb_add_egress_all {
    source = "../../modules/security_group"

    id = data.aws_security_group.sg_svr.id

    operation = "add_cidr"

    type = "egress"
    from = "0.0.0.0/0"
    from_port = 0
    to_port = 0
    protocol = "-1"
}

locals {
    instance_ami = var.instance_ami

    instance_user_data = <<EOT
#!/bin/bash
yum install httpd -y
cd /var/www/html
# Get the secret blob
curl http://vault.${var.dns_zone}/secret1 | base64 --decode | aws kms decrypt --ciphertext-blob fileb:///dev/stdin --query Plaintext --output text --region "${var.aws_region}" > cleartext
service httpd start
chkconfig httpd on
EOT
}


module "websvr" {
    source = "../../modules/ec2-instance"

    instance_ami = local.instance_ami
    instance_name = var.instance_name_client
    instance_subnet = data.aws_subnet.svr.id
    instance_user_data = local.instance_user_data
    instance_key_name = var.key_pair_name
    instance_security_group = data.aws_security_group.sg_svr.id
    iam_instance_profile =  var.iam_instance_profile_name

}
# output "instance_security_group" 
# security group associated with the instance
# output "instance_id"
# Instance id 
# output "instance_public_ip"
# Pubñic IP for the server

