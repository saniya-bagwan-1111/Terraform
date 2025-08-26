# data block will fetch the data from anywhere
data "aws_ami" "aws_ec2_ubuntu_image"{
    most_recent = true
    owners = ["099720109477"]
    filter {
        name ="state"
        values = ["available"]
    }
    filter { # filtering the ubuntu image
        name = "name"
        values = ["ubuntu/images/hvm-ssd/*amd64*"]
    }

}
variable "aws_region" {
    description = "This is terraform variable and region value stored in variable which can be changed"
    default = "eu-west-1"
}
	
# variable "aws_ec2_ami_id" {
#     description = "This is description of ami id"
#     default ="ami-0a729bdc1acf7528b"
# }

variable "aws_ec2_instance_type" {
    description = "This is description of EC2 instance type"
    default = "t2.micro"
}
 variable "aws_ec2_instance_name" {
    default="Terraform-Instance-AWS"
    description = "This is AWS EC2 instance name"
 }

 variable "aws_ec2_root_volume_size" {
    default = 10
    description = "This is AWS EC2 instance volume size"
 }

 variable "aws_ec2_inst_count" {
    description = "This is AWS EC2 instance count"
    default = 1
 }
