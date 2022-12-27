// Variables
variable "domain_name" {
  description = "The name of the domain for our website"
  default = "explorecalifornia.org"
}

// Policies definitions
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "PublicReadGetObject"
    effect = "Allow"
    actions = [ "s3.GetObject" ]
    principals {
      type = "*"
      identifiers = [ "*" ]
    }
    resources = [ "arn:aws:s3:::${var.domain_name}" ]
  }
}

resource "aws_s3_bucket" "website" {
  // Bucket name
  bucket = var.domain_name
  // Policies
  policy = data.aws_iam_policy_document.bucket_policy.json
  // Website options
  website {
    index_document = "index.htm"
    error_document = "error.htm"
  }  
}

// ACL config
resource "aws_s3_bucket_acl" "website_bucket_acl" {
  bucket = aws_s3_bucket.website.id
  acl = "public-read"
}

output "website_bucket_url" {
  value = aws_s3_bucket.website.website_endpoint
}
