

resource "aws_iam_policy" "instance_profile_role_policy" {
    count = length (var.lambda_profiles)

    name = lookup( var.lambda_profiles[count.index], "name" )
    policy = lookup( var.lambda_profiles[count.index], "policy" )
}

resource "aws_iam_role" "instance_profile_role" {
    count = length( aws_iam_policy.instance_profile_role_policy )

    name = aws_iam_policy.instance_profile_role_policy[ count.index ].name
    assume_role_policy = var.lambda_assume_role_policy
}

resource "aws_iam_role_policy_attachment" "attach" {
    count = length( aws_iam_policy.instance_profile_role_policy )

    role       = aws_iam_role.instance_profile_role[ count.index ].name
    policy_arn = aws_iam_policy.instance_profile_role_policy[ count.index ].arn
}

