output "public_ip" {
    value = aws_instance.web.public_ip
    description = "Public IP Address of Instance"
}
