output "s3_bucket_name" {
  value = aws_s3_bucket.spa_bucket.bucket_domain_name
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.spa_cdn.id
}

output "cloudfront_distribution_url" {
  value = aws_cloudfront_distribution.spa_cdn.domain_name
}
