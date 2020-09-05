resource "aws_cloudfront_distribution" "cfd" {
    
    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]    
        cached_methods   = ["GET", "HEAD"]
        viewer_protocol_policy = "allow-all"
        target_origin_id = var.target_origin_id

        forwarded_values {
            cookies {
                forward = "none"
            } 
            query_string = false
        }
    }

    enabled = true

    origin {
        origin_id = var.target_origin_id
        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.cfoai.cloudfront_access_identity_path
        }

        domain_name = var.origin_domain_name 
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}

resource "aws_cloudfront_origin_access_identity" "cfoai" {
}