variable "db_database" {
    type = string
    description = "Database name defined on creation"
}
variable "db_name" {
    type = string
    description = "RDS Instance name"
}           
variable "db_master_user" {
    type = string
    description = "Database master user name"
}

variable "db_master_password" {
    type = string
    description = "Database master password"
}

variable "db_allocated_storage" {
    type = number
    default = 20
    description = "Storage allocated on creation"
}
variable "db_max_allocated_storage" {
    type = number
    default = 0
    description = "Maximum allowed allocated storage on creation. Default is 0, disabling storage grow"
}
variable "db_storage_class" {
    type = string
    default = "gp2"
    description = "Storage class"
}
variable "db_engine" {
    type = string
    default = "mysql"
    description = "DB Engine"
}

variable "db_engine_version" {
    type = string
    default = "5.7"
    description = "DB Engine version."
}


variable "db_subnets" {
    type = list
    description = "List of subnets to deploy the RDB instances"
}

variable "db_instance_class" {
    type = string
    description = "DB Instance type"
    default = "db.t2.micro"
}

variable "db_vpc" {
    type = string
    description = "VPC where the RDS system will be deployed. Used to create Security Group"
}
