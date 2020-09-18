output domain_name {
    value = aws_cloudfront_distribution.cfd.domain_name
} 

output arn {
    value = aws_cloudfront_distribution.cfd.arn
} 

output oai_arn {
    value = aws_cloudfront_origin_access_identity.cfoai.iam_arn
}