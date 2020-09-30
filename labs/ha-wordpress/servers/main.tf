### Creates an autoscaling group with the web servers and attach them to the target group in the ELB

### Search Resources
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
## RDS instance
data "aws_db_instance" "db" {
    db_instance_identifier = var.db_name
}
## Search in network topolgy for public subnets
locals {
    lb_subnets = [ for n in var.vpc_networks : n["cidr_network"] if n["public"] ]
}
data "aws_subnet" "web" {
    count = length( local.lb_subnets )

    vpc_id = data.aws_vpc.vpc.id
    cidr_block = local.lb_subnets[ count.index ]
}
## Search iam instance profile for S3 access
# Not required, because the name is enough
data "aws_iam_instance_profile" "websvr" {
    name = var.iam_instance_profile_name
}
## Search Target Group name
data "aws_lb_target_group" "tg" {
    name = var.lb_target_group_name
}
###

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

## Create user_data 
locals {
    instance_user_data = <<EOT
#!/bin/bash

# Install the required software 
yum install httpd php php-mysql mariadb -y
cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Download Wordpress
/usr/local/bin/wp core download --version=5.1.1

# Configure Wordpress
/usr/local/bin/wp config create --dbhost=${data.aws_db_instance.db.endpoint} --dbname=${var.db_database} --dbuser=${var.db_master_user} --dbpass='${var.db_master_password}'
chmod -R 755 wp-content 
chown -R apache:apache wp-content

# Rewrite httpd config to support URL rewrite based in htaccess
cat /etc/httpd/conf/httpd.conf | awk '/<Directory "\/var\/www\/html">/ { mod = 1 } /<\/Directory>/ {mod=0} /AllowOverride None/ && (mod==1) {print "AllowOverride All" ; next } {print}' > /tmp/aconf
mv /tmp/aconf /etc/httpd/conf/httpd.conf

# Write htaccess
echo "Options +FollowSymlinks" > .htaccess
echo "RewriteEngine on" >> .htaccess
echo 'rewriterule ^wp-content/uploads/(.*)$ http://media.${var.dns_zone}/$1 [r=301,nc]' >> .htaccess

# Start the service
service httpd start
chkconfig httpd on
EOT

}

# Search for a Suitable AMI in this region
data "aws_ami" "wp_ami" {
    most_recent = true
    name_regex = "^amzn2-ami-.*-x86_64-gp2"    
    owners = [ "amazon" ]

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

module kp {
    source  = "../../modules/key_pair"

    kp_name = "Key-${var.lab_name}"
    kp_pub = var.aws_key_pair_pub
}
# output kp_id
# Key Pair ID

module "launch_conf" {
    source  = "../../modules/autoscaling"

    lc_name = var.lc_name
    lc_key_name = module.kp.kp_id
    lc_image_id = data.aws_ami.wp_ami.id 
    lc_instance_type = var.lc_instance_type
    lc_user_data = local.instance_user_data
    lc_iam_instance_profile = data.aws_iam_instance_profile.websvr.name
    lc_security_groups = [ data.aws_security_group.sg_svr.id ]

    ag_name = var.autoscaling_group_name
    ag_min_size = 2
    ag_max_size = 4
    ag_target_group_arns = [ data.aws_lb_target_group.tg.arn ]
    ag_vpc_zone_identifier = data.aws_subnet.web[*].id
}





