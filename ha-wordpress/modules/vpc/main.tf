
resource "aws_vpc" "vpc" {
    cidr_block           = var.vpc_cidr
    instance_tenancy     = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
    }
} # end resource

# Subnets
resource "aws_subnet" "sn" {
    count = length( var.networks )

    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = lookup( var.networks[count.index], "cidr_network" )
    map_public_ip_on_launch = lookup( var.networks[count.index], "public" )
    availability_zone       = lookup( var.networks[count.index], "az" )
    tags = {
        Name = lookup( var.networks[count.index], "name" )
    }
} 

# Create the Internet Gateway
resource "aws_internet_gateway" "ig" {
    vpc_id                  = aws_vpc.vpc.id
    tags = {
        Name = var.vpc_name
    }
} # end resource

# Create the Route Table
resource "aws_route_table" "rt_pub" {
    vpc_id                  = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig.id
    }
    tags = {
        Name = "RT Public - ${var.vpc_name}"
    }
} # end resource

resource "aws_route_table" "rt_priv" {
    vpc_id                  = aws_vpc.vpc.id
    
    tags = {
        Name = "RT Private -  ${var.vpc_name}"
    }
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "rt_ass" {
    count = length( aws_subnet.sn )

    subnet_id = aws_subnet.sn[count.index].id
    # Assign the correct routing table for pub/priv subnets

    route_table_id = aws_subnet.sn[count.index].map_public_ip_on_launch ? aws_route_table.rt_pub.id : aws_route_table.rt_priv.id


} # end resource
