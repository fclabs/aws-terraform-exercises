# Terraform script to create and test AWS Lab Exercises

## Introduction

This series of exercises help you to understand all the resources and services included in the AWS Certificated Associated Exam. For the exam you will need to know how to create them through the AWS Console, but this terraform script will help you to setup each resource and test configurations or compare results.

Additionally, you can use them as a reference about how to create AWS resources with terraform.

To run them, you will need to have terraform installed. A [sample secure.auto.tfvars](./labs/example-secrets.auto.tfvars) is provided. This file is excluded from the repo and is where you are going to setup all your credentials. See ```example-secrets.auto.tfvars``` at root folder. 

Run them going in each directory using make:

```
cd labs/lab-name
make apply
```

Don't forget to destroy all the created resources, that probable will cost you $$$. ```make destroy```will eliminate AWS resources and ```make clean``` will also clean terraform state files. 

```
cd lab
make clean
```

## [Exam Tips & Theory](./exam-tips/readme.md)

## Labs
* [Setup S3 & DynamoDB backend to support tfstate ](./labs/setup-s3-backend)
* [Wordpress Instance with RDS creation from bootscript](./labs/wp-instance-w-rds-lab/)
* [Elastic Load Balancer Classic and Health-Checkers](./labs/elb-classic-lab/)
* [Elastic Load Balancer Application and Health-Checkers](./labs/elb-alb-lab/)
* [Autoscaling Groups with ELB Application and Health-Checkers and CPU target](./labs/auto-scaling/)
* [KMS Key Management and use](./labs/kms-lab/)
* [SSM Parameters used by Lambda function](./labs/ssm-params-lab/)
* [High Availability Wordpress deployment](./labs/ha-wordpress/)
* [Static Website based on S3 and Lambda functions](./labs/webpage-s3-lambda/)
* [Static Website based on S3 sourcing from a CodeCommit Repository using Lambda](./labs/s3-site-from-repo/)



## Wishlist Labs
* Move Instance between regions
* S3 bucket for backup with lifecycle and expiration
* S3 bucket with cross-region-replication (CRR) and MFA deletion for audit records
* S3 Access control options: ACL vs Bucket Policies vs Object ACLs vs Shared Access Links
* AWS Organization OUs with consolidated billing on multiple accounts and Cross-Region Roles
* S3 notifying via SNS a lambda function to process content 
* Deploy ECS with Grafana to monitor CloudWatch
