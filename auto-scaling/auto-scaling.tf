# validation.tf 

#########################################################A
### SECRETS

variable "aws_access_key" { type = string }
variable "aws_secret_key" { type = string }
variable "aws_key_pair_pub" { type = string }
variable "local_key_pair_priv" { type = string }

### Define Secret valies in secrets.auto.tfvars (not included in git repo)
#########################################################A

variable "lab_tag" {
    default = "Auto-Scaling-Lab"
}

variable "instance_ami" {
    default = "ami-02354e95b39ca8dec"
}
variable "instance_type" {
    default = "t2.micro"
}

variable "web_user_data" {
    default = <<EOT
        #!/bin/bash
        yum update -y
        yum install httpd -y
        service httpd start
        chkconfig httpd on
        cd /var/www/html
        echo "<html><h1>This is WebServer" `curl http://169.254.169.254/latest/meta-data/local-ipv4` "</h1></html>" > index.html
    EOT
}

############################################################3
provider "aws" {
  access_key = var.aws_access_key 
  secret_key = var.aws_secret_key 
  region     = "us-east-1"
}

# create the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "192.168.64.0/20"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.lab_tag
    Lab = var.lab_tag
  }
} # end resource

# Subnets
resource "aws_subnet" "pub_us_east_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.168.64.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = var.lab_tag
    Lab = var.lab_tag
  }
} 

resource "aws_subnet" "pub_us_east_1b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.168.65.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = var.lab_tag
    Lab = var.lab_tag
  }
} 

resource "aws_subnet" "pub_us_east_1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.168.66.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = var.lab_tag
    Lab = var.lab_tag
  }
} 

# Create the Internet Gateway
resource "aws_internet_gateway" "ig" {
  vpc_id                  = aws_vpc.vpc.id
  tags = {
    Name = var.lab_tag
    Lab = var.lab_tag
  }
} # end resource

# Create the Route Table
resource "aws_route_table" "rt_main" {
  vpc_id                  = aws_vpc.vpc.id
  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = var.lab_tag
    Lab = var.lab_tag
  }
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "rt_ass_us_east_1a" {
  subnet_id      = aws_subnet.pub_us_east_1a.id
  route_table_id = aws_route_table.rt_main.id 
} # end resource
resource "aws_route_table_association" "rt_ass_us_east_1b" {
  subnet_id      = aws_subnet.pub_us_east_1b.id
  route_table_id = aws_route_table.rt_main.id 
} # end resource
resource "aws_route_table_association" "rt_ass_us_east_1c" {
  subnet_id      = aws_subnet.pub_us_east_1c.id
  route_table_id = aws_route_table.rt_main.id 
} # end resource

# Security Groups for instances
resource "aws_security_group" "web_server" {
    vpc_id                  = aws_vpc.vpc.id
    name = "SG Web Server"
    description = "SG Web Server"
    ingress {
        description = "Allow HTTP from anywere"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow SSH from anywere"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow egress traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "SG Web Server"
        Lab = var.lab_tag
    }
}

# Import in AWS pub key
resource "aws_key_pair" "lab" {
    key_name   = "lab"
    public_key = var.aws_key_pair_pub
}




# Security Groups for instances
resource "aws_security_group" "elb_web" {
    vpc_id                  = aws_vpc.vpc.id
    name = "ELB Web Server"
    description = "ELB  Web Server"
    ingress {
        description = "Allow HTTP from anywere"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow egress traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "sg ELB Web"
        Lab = var.lab_tag
    }
}

resource "aws_lb_target_group" "web" {
    name = "tg-web"
    target_type = "instance"
    protocol = "HTTP"
    port = "80"
    vpc_id = aws_vpc.vpc.id

    health_check {
        enabled=true
        interval = 5
        path = "/index.html"
        port = 80
        protocol = "HTTP"
        timeout = 4
        healthy_threshold = 2
        unhealthy_threshold = 3
        matcher = "200"
    }

    tags = {
        Name = "Target Group Web"
        Lab = var.lab_tag
    }
}

resource "aws_lb" "web" {
    name = "WebFront"
    internal = false
    load_balancer_type = "application"
    ip_address_type = "ipv4"
   
    security_groups = [aws_security_group.elb_web.id]

    subnets = [ aws_subnet.pub_us_east_1a.id , aws_subnet.pub_us_east_1b.id  , aws_subnet.pub_us_east_1c.id  ]

    tags = {
        Name = "Elastic Load Balancer Web"
        Lab = var.lab_tag
    }
}

resource "aws_lb_listener" "Web80" {
    load_balancer_arn = aws_lb.web.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.web.arn
    }
}

resource "aws_launch_configuration" "as_conf" {
    name_prefix = "WebServers-"
    image_id = var.instance_ami
    instance_type = var.instance_type
    key_name = aws_key_pair.lab.id
    user_data = var.web_user_data
    security_groups = [ aws_security_group.web_server.id ]

    root_block_device {
        volume_size = 8
        delete_on_termination = true
    }
     
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "as_grp" {
    name = "WebASG"    
    launch_configuration = aws_launch_configuration.as_conf.id

    max_size = 6
    min_size = 3

    target_group_arns = [aws_lb_target_group.web.arn]
    vpc_zone_identifier = [ aws_subnet.pub_us_east_1a.id , aws_subnet.pub_us_east_1b.id  , aws_subnet.pub_us_east_1c.id  ]

    tags = [ 
    {
        "key" = "Name" 
        "value" = "Autoscaling group Web"
        "propagate_at_launch" = true
    },
    {
        "key" = "Lab" 
        "value" = var.lab_tag
        "propagate_at_launch" = true
    } ]
}


