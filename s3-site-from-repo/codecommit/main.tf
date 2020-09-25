
## Create Repository
resource "aws_codecommit_repository" "repo" {
    repository_name = local.codecommit_repo
    description     = var.lab_name
}

## Create a new policy 
locals {
    lambda_codecommit_policy = <<EOP
{
    "Version": "2012-10-17",
    "Id": "CodeCommitAccess",
    "Statement": [
        {
            "Sid": "PullRepoAccess",
            "Effect": "Allow",
            "Action": [
                "codecommit:Get*"
            ],
            "Resource": [
                "${aws_codecommit_repository.repo.arn}"
            ]
        }
    ]
}
EOP
}

## Creates and attach another policy to the Lambda Role, now that the repository is created.
resource "aws_iam_policy" "lambda_codecommit_policy" {
    name        = "${var.lambda_role_name}-Lambda-CodeCommit-Policy"
    policy = local.lambda_codecommit_policy
}
resource "aws_iam_role_policy_attachment" "cc-attach" {
    role = var.lambda_role_name
    policy_arn = aws_iam_policy.lambda_codecommit_policy.arn
}

## Add CodeCommit as a authorized trigger to the lambda function
data "aws_lambda_function" "func" {
    function_name = var.lambda_function_name
}
resource "aws_lambda_permission" "lambda_permission" {
    statement_id  = "AllowCodeCommitInvoke"
    action = "lambda:InvokeFunction"
    function_name = var.lambda_function_name
    principal = "codecommit.amazonaws.com"

    source_arn = aws_codecommit_repository.repo.arn
}

# Add CodeCommit trigger
resource "aws_codecommit_trigger" "trigger" {
    repository_name = local.codecommit_repo

    trigger {
        name = "OnPush"
        events = ["all"]
        branches = [var.codecommit_branch]
        destination_arn = data.aws_lambda_function.func.arn
  }
}

