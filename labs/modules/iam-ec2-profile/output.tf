output "instance_profiles" {
    value = [ for ra in aws_iam_instance_profile.instance_profile : ra.name ]
}