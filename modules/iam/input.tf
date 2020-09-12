


## List of Maps with role definition
# Name: Name of the Instance Policy 
# Policy: The policy that grants an entity permission to assume the role.
#
variable "instance_profiles" {
    description = "Roles required to be created. Specific for instance policies"
    type = list
    default = []
}

variable "ec2_assume_role_policy" {
    default = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Action": "sts:AssumeRole",
    "Principal": {
        "Service": "ec2.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
    }
]
}
EOF   
}