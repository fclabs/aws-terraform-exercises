


locals {
    str_list_admin = join( " , " , [ for i in var.kms_admin_arns : "\"${i}\"" ] )
    str_list_use = join( " , " , [ for i in var.kms_usage_arns : "\"${i}\"" ] )
}

locals {
    kms_root_policy = <<EOP
{
    "Sid": "Enable root account access to this key",
    "Effect": "Allow",
    "Principal": {"AWS": ${var.kms_root_arn}},
    "Action": "kms:*",
    "Resource": "*"
}
EOP
    kms_admin_policy = <<EOP
{
    "Sid": "Allow access for Key Administrators",
    "Effect": "Allow",
    "Principal": {
        "AWS": [ ${local.str_list_admin} ]
    },
    "Action": [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
    ],
    "Resource": "*"
}
EOP
    kms_use_policy = <<EOP
{
    "Sid": "Allow the use of the key",
    "Effect": "Allow",
    "Principal": {
        "AWS": [ ${local.str_list_use} ]
    },
    "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
    ],
    "Resource": "*"
},
{
    "Sid": "Allow attachment of persistent resources",
    "Effect": "Allow",
    "Principal": {
        "AWS": [ ${local.str_list_use} ]
    },
    "Action": [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
    ],
    "Resource": "*", "Condition": {
        "Bool": {
            "kms:GrantIsForAWSResource": "true"
        }
    }
}
EOP
}

locals {
    kms_policy = <<EOP
{
    "Id": "${var.kms_policy_name}",
    "Version": "2012-10-17",
    "Statement": [
        ${local.kms_root_policy},
        ${local.kms_admin_policy},
        ${local.kms_use_policy}
    ]
}
EOP
}