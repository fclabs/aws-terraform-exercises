

# Create launch configuration if lc_create in true
resource "aws_launch_configuration" "lc_new" {
    
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

### Autoscaling group

resource "aws_autoscaling_group" "ag_new" {
    
    name = var.ag_name
    
    launch_configuration = aws_launch_configuration.lc_new.id
    max_size = var.ag_max_size
    min_size = var.ag_min_size
    target_group_arns = var.ag_target_group_arns
    vpc_zone_identifier = var.ag_vpc_zone_identifier 

}
