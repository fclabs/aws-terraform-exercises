output "lambda_roles" {
    value = [ for ra in aws_iam_role.instance_profile_role : ra.name ]
}

output "lambda_role_arns" {
    value = { for ra in aws_iam_role.instance_profile_role : ra.name => ra.arn }
}