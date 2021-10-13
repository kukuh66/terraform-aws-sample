output "public_ip"{
    value       = aws_instance.sample1.public_ip
    description = "Ip public for web server"
}