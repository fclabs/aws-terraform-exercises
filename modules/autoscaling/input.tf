### Mandatory input

### Launch configuration vars
variable "lc_name" {
    type = string
    description = "Launch configuration group Name. Mandatory"
    default = ""
}
variable "lc_create" {
    type = bool
    description = "Define if the Launch configuration group needs to be created. Default false"
    default = false
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

### Autoscaling group vars
# variable "ag_name" {
#     type = string
#     description = "Autoscaling group Name. Mandatory"
#     default = ""
# }

# variable "ag_create" {
#     type = bool
#     description = "Define if the Launch configuration group needs to be created. Default false"
#     default = false
# }

###


