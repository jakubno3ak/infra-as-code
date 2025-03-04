resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-${random_id.bucket_suffix.hex}"
  tags = {
    Name = "my-bucket"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}
