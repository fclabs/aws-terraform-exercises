variable "instance_name" {
    type = string
    description = "Instance Name. Required"
}

variable "instance_ami" {
    type = string
    description = "Instance AMI.Required"
}

variable "instance_subnet" {
    type = string
    description = "Instance VPC Subnet were the instance will be deployed.Required"
}

variable "instance_type" {
    type = string
    description = "Instance type. Default t3.micro"
    default = "t3.micro"
}

variable "instance_user_data" {
    type = string
    description = "User data to exeute at instance creation. Default: no user data"
    default = null
}

variable "instance_security_group" {
    type = string
    description = "Instance Security Group to be assigned. If it's not defined, an new empty one will be created"
    default = null
}