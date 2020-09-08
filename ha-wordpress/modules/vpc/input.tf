variable "vpc_name" {
    type = string
    default = "VPN-Lab"
}

variable "vpc_cidr" {
    type = string
    description = "Base CIDR for VPC"
}

variable "networks" {
    type = list 
    description = "List of subnet definitions"
    default = []
}