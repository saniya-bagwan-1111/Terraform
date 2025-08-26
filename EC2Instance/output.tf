output "ec2_instance_public_ip" {
    value = aws_instance.terra_instance[*].public_ip
}

output "ec2_instance_private_ip" {
    value = aws_instance.terra_instance[*].private_ip# here count variable present in Ec2 tf file that is why we have to provide [*] to get ip based on instance index
}
