# Import in AWS pub key
resource "aws_key_pair" "kp" {
    key_name   = var.kp_name
    public_key = var.kp_pub
}