
aws_region = "us-east-1"

lab_name = "WP-HA-Stack"
sg_name_websvr = "WP-HA-Stack-SG-WebServer"
sg_name_lbfront = "WP-HA-Stack-SG-LB-Front"

bucket_name_media = "fclabs-wordpress-ha-media"
bucket_name_code = "fclabs-wordpress-ha-code"
iam_instance_profile_name = "Wordpress-HA-S3-Buckets-Access"

cf_target_origin_id = "S3Media-WP-HA"

db_database = "wordpress"
db_name = "wordpress-ha"

lb_name = "Wordpress-HA-ELB-Front-Web"
lb_target_group_name = "WebFrontHTTP"

lc_name = "LC-WebServer"
lc_image = "ami-0a2863cbddcdf0a93"
lc_instance_type = "t2.micro"

autoscaling_group_name = "AG-WebServer"
