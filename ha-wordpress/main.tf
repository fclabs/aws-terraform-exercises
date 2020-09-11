

### Create S3 buckets
module "s3_media" {
    source = "./modules/s3"
    bucket = var.bucket_name_media
}

module "s3_code" {
    source = "./modules/s3"
    bucket = var.bucket_name_code
}

### Create IAM Policy to manage the S3 buckets fron the instances
locals {
    s3_instance_policy = <<EOT
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "ObjectActions",
                    "Effect": "Allow",
                    "Action": [
                        "s3:PutObject",
                        "s3:PutObjectAcl",
                        "s3:GetObject",
                        "s3:GetObjectAcl",
                        "s3:DeleteObject"
                    ],
                    "Resource": [ "${module.s3_media.arn}/*" , "${module.s3_code.arn}/*" ]
                },
                {
                    "Sid": "ListObjectBucket",
                    "Effect": "Allow",
                    "Action": "s3:ListBucket",
                    "Resource": [ "${module.s3_media.arn}" , "${module.s3_code.arn}" ]
                }
            ]
        }
    EOT
}

### Create CloufFront distribution
#module "cloudfront-media" {
#    source = "./modules/cloudfront"
#
#    target_origin_id = var.cf_target_origin_id 
#    origin_domain_name = module.s3_media.bucket_domain_name
#}

module "vpc" {
    source = "./modules/vpc"

    vpc_name = "Lab-WP-HA"
    vpc_cidr  = var.vpc_cidr
    networks = var.vpc_networks 
}

### Create RDS instance
# module "rds" {
#     source = "./modules/rds"

#     db_master_user = var.db_master_user
#     db_master_password = var.db_master_password
#     db_database = var.db_database
#     db_name = var.db_name
#     db_subnets = module.vpc.vpc_subnet_privs
#     db_vpc = module.vpc.id
# }
            
output "debug_vpc_id" {
    value = module.vpc.id
}
output "debug_sub_privs" {
    value = module.vpc.vpc_subnet_pubs
}
output "debug_sub_pubs" {
    value = module.vpc.vpc_subnet_privs
}
output "debug_s3_media_arn" {
    value = module.s3_media.arn
}
output "debug_s3_code_arn" {
    value = module.s3_code.arn
}
output "debug_iam_policy" {
    value = local.s3_instance_policy
}