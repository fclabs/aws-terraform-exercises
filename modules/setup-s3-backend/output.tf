output "bucket_name" {
    value = aws_s3_bucket.terraform_state.id
}
output "dynamodb_name" {
    value = aws_dynamodb_table.terraform_locks.name
}
output "bucket_arn" {
    value = aws_s3_bucket.terraform_state.arn
}
output "dynamodb_arn" {
    value = aws_dynamodb_table.terraform_locks.arn
}