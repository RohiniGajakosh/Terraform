output "public_ip" {
  value = aws_instance.myec2[*].public_ip
}
output "public_dns" {
  value = aws_instance.myec2[*].public_dns
}