module "cloudfront" {
  source = "terraform-aws-modules/cloudfront/aws"

  create_origin_access_identity = true
  origin_access_identities = {
    s3_frontend_bucket = "Frontend bucket"
  }
  origin = {
    frontend_bucket = {
      domain_name = module.s3_frontend_bucket.s3_bucket_bucket_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_frontend_bucket"
      }
    }
  }
  default_root_object = "index.html"
  default_cache_behavior = {
    target_origin_id       = "frontend_bucket"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true
  }
}

output "cdn_domain" {
  value = module.cloudfront.cloudfront_distribution_domain_name
}