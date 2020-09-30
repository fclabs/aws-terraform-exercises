

## Create subnet group
resource "aws_db_subnet_group" "sg" {
    name       = "${var.db_name}-main"
    subnet_ids = var.db_subnets
    tags = {
        Name = "${var.db_name}-main"
    } 

}

# Create a security group to associate with the RDS instance.
resource "aws_security_group" "rds_sg" {
    name = "${var.db_vpc}-${var.db_name}-sg-main"
    vpc_id = var.db_vpc

    # The security will ingress empty and egress allowed to anywhere
    # It could be modified later
    egress {
        description = "Allow egress traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.db_vpc}-${var.db_name}-sg-main"
        VPC = var.db_vpc
        RDS = var.db_name
    }
}

resource "aws_db_instance" "db" {
    max_allocated_storage = var.db_max_allocated_storage 
    
    allocated_storage = var.db_allocated_storage 
    storage_type = var.db_storage_class
    
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    
    name = var.db_database
    username = var.db_master_user
    password = var.db_master_password
    
    multi_az = var.db_multi_az
    db_subnet_group_name = aws_db_subnet_group.sg.name
    publicly_accessible = false
    skip_final_snapshot = true

    identifier = var.db_name
    vpc_security_group_ids = [ aws_security_group.rds_sg.id ]


    tags = {
        Name = var.db_name
    } 
}