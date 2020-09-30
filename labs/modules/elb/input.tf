
variable "lb_name" {
    type = string
    description = "ELB Name. Mandatory"
}
variable "lb_security_groups" {
    type = list(string)
    description = "List of ELB securoty groups. Mandatory" 
    default = null
}
variable "lb_subnets" {
    type = list(string)
    description = "List of ELB subnets were the ELB will have an EIP to connect to backend servers. One per AZ, minimun two. Mandatory" 
    default = null
}




variable "lb_create" {
    type = bool
    description = "Define if the ELB need sto be created. Default false"
    default = false
}

variable "lb_internal" {
    type = string
    description = "Define if ELB will be internal or external (with public FQDN). Default: false (External)"
    default = false
}
variable "lb_type" {
    type = string 
    description = "ELB type. Valid values are application and network. Default: application " 
    default = "application"
}
variable "lb_ip_address_type" {
    type = string 
    description = "ELB type. Valid values are application and network. Default: application " 
    default = "ipv4"
}

# List of Target Groups
# Each element is a map of:
# name: Target Group Name
# port: Port number
# vpc_id: vpc id where the targets will live
variable "lb_target_groups" {
    type = list 
    description = "Target Groups to be created. Default: empty. No Target Group is created " 
    default = []
}

# List of Target Groups
# Each element is a map of:
# name: Target Group Name
# targets: list of instance ids
variable "lb_target_group_attach" {
    type = list 
    description = "Instances to be attached to the target group. Default: Empty. No attachs." 
    default = []
}

