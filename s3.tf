module "s3_frontend_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
}

data "aws_iam_policy_document" "s3_policy_allow_cloudfront" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_frontend_bucket.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.cloudfront_origin_access_identity_iam_arns
    }
  }
}

resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = module.s3_frontend_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy_allow_cloudfront.json
}

output "bucket_name" {
  value = module.s3_frontend_bucket.s3_bucket_id 
}
