

variable "kms_root_arn" {
    description = "Root ARN. Mandatory"
    type = string
}

variable "kms_policy_name" {
    description = "Policy Name to be used in the ID"
    type = string
    default = ""
}


variable "kms_admin_arns" {
    type = list(string)
    default = []
    description = "List of ARNs allowed to manage the key"
}

variable "kms_usage_arns" {
    default = []
    type = list(string)
    description = "List of ARNs allowed to use the key"
}
