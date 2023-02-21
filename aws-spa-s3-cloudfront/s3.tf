resource "aws_s3_bucket" "spa_bucket" {
  bucket = "${var.app_name}-spa-${var.environment}"

  tags = {
    Name = "${var.app_name} SPA ${var.environment}"
  }
}

resource "aws_s3_bucket_acl" "spa_bucket_acl" {
  bucket = aws_s3_bucket.spa_bucket.id
  acl    = "private"
}

data "aws_iam_policy_document" "spa_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.spa_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.spa_oai.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "spa_bucket_policy" {
  bucket = aws_s3_bucket.spa_bucket.id
  policy = data.aws_iam_policy_document.spa_policy_document.json
}