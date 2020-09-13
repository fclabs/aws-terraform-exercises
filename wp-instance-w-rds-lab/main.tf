module "vpc" {
    source = "../modules/vpc"

    vpc_name = "Lab-WP-HA"
    vpc_cidr  = var.vpc_cidr
    networks = var.vpc_networks 
}
# output "vpc_subnet_privs" 
# List of private subnet ids 
# output "vpc_subnet_pubs" 
# List of public subnets ids
# output "id" 
# VPC id


### Create RDS instance
module "rds" {
    source = "../modules/rds"

    db_master_user = var.db_master_user
    db_master_password = var.db_master_password
    db_database = var.db_database
    db_name = var.db_name
    db_subnets = module.vpc.vpc_subnet_privs
    db_vpc = module.vpc.id
    db_multi_az = false
}
# output "db_security_group" 
# RDS Security group
# output "db_endpoint"
# FQDN:port to use to connect to database

# Create a Security Group for the Web Instance
module sgweb_create {
    source = "../modules/security_group"

    vpc_id = module.vpc.id
}

# Add SSH ingress rule for Web Server Instance
module sgweb_add_ssh {
    source = "../modules/security_group"

    id = module.sgweb_create.security_group_id

    operation = "add_cidr"

    type = "ingress"
    from = "0.0.0.0/0"
    from_port = 22
    to_port = 22
    protocol = "tcp"
}
# Add Egreee rule for Web Server Instance
module sgweb_add_egress_all {
    source = "../modules/security_group"

    id = module.sgweb_create.security_group_id

    operation = "add_cidr"

    type = "egress"
    from = "0.0.0.0/0"
    from_port = 0
    to_port = 0
    protocol = "-1"
}

# Add MYSQL access from WebSvr security group to RDS instance
module sgrds_add_mysql {
    source = "../modules/security_group"

    id = module.rds.db_security_group

    operation = "add_source_sg"

    type = "ingress"
    from = module.websvr.instance_security_group
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
}


locals {
    instance_ami = var.instance_ami

    instance_user_data = <<EOT
#!/bin/bash
yum install httpd php php-mysql -y
cd /var/www/html
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.1.1.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content
service httpd start
chkconfig httpd on
EOT

}

module kp {
    source  = "../modules/key_pair"

    kp_name = "lab"
    kp_pub = var.aws_key_pair_pub
}
# output kp_id
# Key Pair ID



module "websvr" {
    source = "../modules/ec2-instance"

    instance_ami = local.instance_ami
    instance_name = var.instance_name
    instance_subnet = module.vpc.vpc_subnet_pubs[0]
    instance_user_data = local.instance_user_data
    instance_key_name = module.kp.kp_id
    instance_security_group = module.websvr.instance_security_group
}
# output "instance_security_group" 
# security group associated with the instance
# output "instance_id"
# Instance id 
