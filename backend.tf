 resource "aws_s3_bucket" "backend_bucket" {
   bucket = "bucket-backend-k1"
 }
 resource "aws_s3_bucket_versioning" "version" {
   bucket = aws_s3_bucket.backend_bucket.id
     versioning_configuration {
         status = "Enabled"
     }
 }
resource "aws_s3_bucket_server_side_encryption_configuration" "encryp" {
     bucket = aws_s3_bucket.backend_bucket.bucket
     rule {
         apply_server_side_encryption_by_default {
             sse_algorithm = "AES256"
         }
     }
 }
# resource "aws_dynamodb_table" "locking" {
#     name         = "backend-locking"
#     billing_mode = "PAY_PER_REQUEST"
#     attribute {
#         name = "LockID"
#         type = "S"
#     }
#     hash_key = "LockID"
# }
