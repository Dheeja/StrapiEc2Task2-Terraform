output "instance_name" {
  value = aws_instance.strapi_ec2.tags["Name"]
}


output "public_ip" {
  value = aws_instance.strapi_ec2.public_ip
}