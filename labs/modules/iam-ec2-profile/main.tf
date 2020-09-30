

resource "aws_iam_policy" "instance_profile_role_policy" {
    count = length (var.instance_profiles)

    name = lookup( var.instance_profiles[count.index], "name" )
    policy = lookup( var.instance_profiles[count.index], "policy" )
}

resource "aws_iam_role" "instance_profile_role" {
    count = length( aws_iam_policy.instance_profile_role_policy )

    name = aws_iam_policy.instance_profile_role_policy[ count.index ].name
    assume_role_policy = var.ec2_assume_role_policy
}

resource "aws_iam_role_policy_attachment" "attach" {
    count = length( aws_iam_policy.instance_profile_role_policy )

    role       = aws_iam_role.instance_profile_role[ count.index ].name
    policy_arn = aws_iam_policy.instance_profile_role_policy[ count.index ].arn
}

resource "aws_iam_instance_profile" "instance_profile" {
    count = length( aws_iam_role.instance_profile_role )

    name       = aws_iam_role.instance_profile_role[ count.index ].name
    role       = aws_iam_role.instance_profile_role[ count.index ].name
}