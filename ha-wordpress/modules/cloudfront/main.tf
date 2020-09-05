resource "aws_cloudfront_distribution" "cfd" {
    
    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]    
        cached_methods   = ["GET", "HEAD"]
        viewer_cache_protocol = "allow-all"
        target_origin_id = var.target_origin_id

        forwarded_values {
            cookies {
                forward = "none"
            } 
            query_string = "*"           
        }
    }

    enabled = true

    origin {
        s3_origin_config {}

        domain_name = var.origin_domain_name 
    }
}