resource "aws_acm_certificate" "api" {
  domain_name       = "api.rawatjalan.site"
  validation_method = "DNS"
    
}

data "aws_route53_zone" "public-rawat-jalan" {
  name         = "rawatjalan.site"
  private_zone = false
    
}

resource "aws_route53_record" "api-validation-example-3" {
  for_each = {
    for dvo in aws_acm_certificate.api.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public-rawat-jalan.zone_id
    
}

resource "aws_acm_certificate_validation" "api" {
  certificate_arn         = aws_acm_certificate.api.arn
  validation_record_fqdns = [for record in aws_route53_record.api-validation-example-3 : record.fqdn]
    
}





resource "aws_acm_certificate" "www" {
  domain_name       = "www.rawatjalan.site"
  validation_method = "DNS"
    
}

resource "aws_route53_record" "www" {
  for_each = {
    for dvo in aws_acm_certificate.www.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public-rawat-jalan.zone_id
    
}

resource "aws_acm_certificate_validation" "www" {
  certificate_arn         = aws_acm_certificate.www.arn
  validation_record_fqdns = [for record in aws_route53_record.www : record.fqdn]
    
}

resource "aws_route53_record" "www-validation" {
  for_each = {
    for dvo in aws_acm_certificate.www.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public-rawat-jalan.zone_id
}

