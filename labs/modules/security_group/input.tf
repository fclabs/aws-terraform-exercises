variable id {
    type = string
    description = "id of the Security Group to modify. If is not defined, then an empty security group will be defined."
    default = null 
}

variable vpc_id {
    type = string
    description = "VPC were the security groupo will be created. Default null. If the operation is create, it will create the SG in the default VPC"
    default = null
}

variable name {
    type = string
    description = "The name of the security group. If omitted, Terraform will assign a random, unique name"
    default = null
}

variable operation {
    type = string
    description = "Operation to be done in the security group. Valid values: create (default), add_cidr, add_source_sg"
    default = "create"
}

variable type {
    type = string
    description = "(Required) The type of rule being created. Valid options are ingress (inbound) or egress (outbound)."
    default = "ingress"
}

variable from {
    type = string
    description = "Security Group or CIDR block"
    default = null
}

variable from_port {
    type = number
    description = "The start port (or ICMP type number if protocol is icmp or icmpv6)"    
    default = null
}

variable to_port {
    type = number
    description = "(Required) The end port (or ICMP code if protocol is icmp)."    
    default = null
}

variable protocol {
    type = string
    description = "The protocol. If not icmp, icmpv6, tcp, udp, or -1 use the protocol number. Required"    
    default = null
}
