


## List of Maps with role definition
# name: Name of the Instance Policy 
# policy: The policy that grants an entity permission to assume the role.
#
variable "lambda_profiles" {
    description = "Roles required to be created. Specific for lambda profiles"
    type = list
    default = []
}

variable "lambda_assume_role_policy" {
    default = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Action": "sts:AssumeRole",
    "Principal": {
        "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
    }
]
}
EOF   
}