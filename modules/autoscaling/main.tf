

# Search launch configuration if the name is not empty and lc_create is not true
data "aws_launch_configuration" "lc_old" {
    count = (var.lc_name != "" && !var.lc_create) ? 1 : 0 

    name = var.lc_name
}
 
# Create launch configuration if lc_create in true
resource "aws_launch_configuration" "lc_new" {
    count = var.lc_create ? 1 : 0 

    name = var.lc_name
    image_id = var.lc_image_id
    instance_type = var.lc_instance_type
    user_data = var.lc_user_data
    key_name = var.lc_key_name
    iam_instance_profile = var.lc_iam_instance_profile
    security_groups = var.lc_security_groups

    lifecycle {
        create_before_destroy = true
    }
}

locals {
    launch_group_name = var.lc_create ? aws_launch_configuration.lc_new[0].name : data.aws_launch_configuration.lc_old[0].name
}