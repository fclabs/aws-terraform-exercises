### Mandatory input

### Launch configuration vars
variable "lc_name" {
    type = string
    description = "Launch configuration group Name. Mandatory"
}
variable "lc_image_id" {
    type = string
    description = "Image id for the launch configuration group"
    default = ""
}
variable "lc_instance_type" {
    type = string
    description = "Instance type for the launch configuration group"
    default = null
}

variable "lc_user_data" {
    type = string
    description = "User Data for launch configuration"
    default = null
}
variable "lc_key_name" {
    type = string
    description = "Key name for launch configuration"
    default = null
}
variable "lc_iam_instance_profile" {
    type = string
    description = "Instance Profile for launch configuration"
    default = null
}
variable "lc_security_groups" {
    type = list
    description = "Security Groups for launch configuration"
    default = null
}
###


variable "ag_name" {
    type = string
    description = "Autoscaling group Name. Mandatory"
}
variable "ag_launch_configuration" {
    type = string
    description = "Launch configuration group for the autoscaling group"
    default = null
}
variable "ag_min_size" {
    type = number
    description = "Autoscaling group min size. Required"
    default = null
}
variable "ag_max_size" {
    type = number
    description = "Autoscaling group min size. Required"
    default = null
}
variable "ag_target_group_arns" {
    type = list(string)
    description = "Autoscaling group target group to be updated. Required"
    default = null
}
 
variable "ag_vpc_zone_identifier" {
    type = list(string)
    description = "Autoscaling group vpc_zone_identifier were deploy. Required"
    default = null
}

###


