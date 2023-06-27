# resource "aws_wafv2_web_acl_association" "cloudfront_waf_acl_association" {
#   resource_arn = aws_cloudfront_distribution.cloudfront.arn
#   web_acl_arn  = aws_wafv2_web_acl.cloudfront_waf_acl.arn

# }

# resource "aws_wafv2_web_acl" "cloudfront_waf_acl" {
#   name        = "cloudfront-waf-acl"
#   description = "AWS WAF ACL for CloudFront"
#   scope       = "CLOUDFRONT"


#   default_action {
#     allow {}
#   }

#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "CloudFrontWAFACL"
#     sampled_requests_enabled   = true
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesAmazonIpReputationList"
#     priority = 1
#     action {
#       block {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWS-AWSManagedRulesAmazonIpReputationList"
#         vendor_name = "AWS"
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "CloudFrontWAFACL"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesAnonymousIpList"
#     priority = 2
#     action {
#       block {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWS-AWSManagedRulesAnonymousIpList"
#         vendor_name = "AWS"
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "CloudFrontWAFACL"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
#     priority = 3
#     action {
#       block {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
#         vendor_name = "AWS"
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "CloudFrontWAFACL"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesLinuxRuleSet"
#     priority = 4
#     action {
#       block {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWS-AWSManagedRulesLinuxRuleSet"
#         vendor_name = "AWS"
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "CloudFrontWAFACL"
#       sampled_requests_enabled   = true
#     }
#   }

#   # Add more rules as needed

#   tags = {
#     Name = "CloudFront-WAF-ACL"
#   }
# }
