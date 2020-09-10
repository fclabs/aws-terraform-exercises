variable "db_database" {
    type = string
    description = "Database name that will be created initially"
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
    type = numeric
    default = 20
    description = "Storage allocated on creation"
}

variable "db_subnets" {
    type = list
    description = "List of subnets to deploy the RDB instances"
}

