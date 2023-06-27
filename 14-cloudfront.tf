resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = "pendaftaran-rawat-jalan-rs-medika-utama.s3.amazonaws.com"
    origin_id   = "S3-Origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  http_version    = "http2"
  price_class     = "PriceClass_200"

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.www.arn
    ssl_support_method  = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "S3-Origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["ID"]
    }
  }
}

# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = "pendaftaran-rawat-jalan-rs-medika-utama"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "PublicReadGetObject",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_distribution.cloudfront.arn}"
#       },
#       "Action": "s3:GetObject",
#       "Resource": "arn:aws:s3:::pendaftaran-rawat-jalan-rs-medika-utama/*"
#     }
#   ]
# }
# EOF
# }

// menambahkan DNS Route 53 dengan alias untuk CloudFront
resource "aws_route53_record" "rawatjalan" {
  zone_id = data.aws_route53_zone.public-rawat-jalan.zone_id
  name    = "rawatjalan.site"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_rawatjalan" {
  zone_id = data.aws_route53_zone.public-rawat-jalan.zone_id
  name    = "www.rawatjalan.site"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}
