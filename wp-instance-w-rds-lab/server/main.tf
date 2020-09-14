
### Search for resources
## VPC
data "aws_vpc" "vpc" {
    tags = {
        Name = var.lab_name
    }
}
## Search for Web Server Security Group
data "aws_security_group" "sg_svr" {
    name = var.sg_name_websvr
}
## RDS instance
data "aws_db_instance" "db" {
    db_instance_identifier = var.db_name
}
## Subnet that will hold de server
data "aws_subnet" "svr" {
    vpc_id = data.aws_vpc.vpc.id
    cidr_block = var.server_subnet_cidr
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
yum install httpd php php-mysql mariadb -y
cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
/usr/local/bin/wp core download --version=5.1.1
/usr/local/bin/wp config create --dbhost=${data.aws_db_instance.db.endpoint} --dbname=${var.db_database} --dbuser=${var.db_master_user} --dbpass='${var.db_master_password}'
chmod -R 755 wp-content
chmod 
chown -R apache:apache wp-content
cat /etc/httpd/conf/httpd.conf | awk '/<Directory "\/var\/www\/html">/ { mod = 1 } /<\/Directory>/ {mod=0} /AllowOverride None/ && (mod==1) {print "AllowOverride All" ; next } {print}' > /tmp/aconf
mv /tmp/aconf /etc/httpd/conf/httpd.conf
service httpd start
chkconfig httpd on
EOT

}

module kp {
    source  = "../../modules/key_pair"

    kp_name = "lab"
    kp_pub = var.aws_key_pair_pub
}
# output kp_id
# Key Pair ID

module "websvr" {
    source = "../../modules/ec2-instance"

    instance_ami = local.instance_ami
    instance_name = var.instance_name
    instance_subnet = data.aws_subnet.svr.id
    instance_user_data = local.instance_user_data
    instance_key_name = module.kp.kp_id
    instance_security_group = data.aws_security_group.sg_svr.id

}
# output "instance_security_group" 
# security group associated with the instance
# output "instance_id"
# Instance id 
