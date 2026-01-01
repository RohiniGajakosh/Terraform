#outputs for multiple instances using count

# output "public_ip" {
#   value = aws_instance.myec2[*].public_ip
# }
# output "public_dns" {
#   value = aws_instance.myec2[*].public_dns
# }

# outputs for multiple instances using for loop                                                                 
output "public_ip" {
  value = [for key in aws_instance.myec2 : key.public_ip]
  
}

output "public_dns" {
  value = [for key in aws_instance.myec2 : key.public_dns]
}

# output "bucket_name" {
#   value = aws_s3_bucket.maabucket.bucket
# }
# output "s3_object_url" {
#   value = "${aws_s3_bucket.maabucket.bucket}/${aws_s3_object.bucket_object.key}"
# }