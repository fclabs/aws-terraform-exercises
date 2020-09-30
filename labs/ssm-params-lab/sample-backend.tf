###
### Setup the S3 backend file for a shared stae file for the different resources groups

terraform {
    backend "s3" {
        bucket         = "your-lab-terraform-state"
        key            = "lab-name/terraform.tfstate"
        region         = "us-east-1"
        # Replace this with your DynamoDB table name!
        dynamodb_table = "your-lab-terraform-state"
        encrypt        = true
    }
}
