resource "aws_key_pair" "terraform_instance" {
    key_name = "terra-instance-key"
    public_key =  file ("terra-instance-key.pub")#pulic key file paath or directly paste public key
}

resource "aws_default_vpc" "default" {
    #default vpc is not a configureable, so not required to add arguments
}
resource "aws_security_group" "terra_ins_sec_grp" {
    name = "My Z plus Security"
    description = "This is Security Group created by terraform"
    vpc_id = aws_default_vpc.default.id  # this is called interpolation
	
	#inbound Rules
	ingress {
		description = "Allow Access to SSH port 22"
		from_port = 22 # mensioned in lunch instance as Port Range
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"] # publically available
	}
	
	ingress {
		description = "Allow to access HTTP port"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	
	#outbound Rules
	egress {
		description = "allow all outgoing traffic"
		to_port = 0
		from_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "My Z plus Security" #optional
	}
}

resource "aws_instance" "terra_instance" {
	count = var.aws_ec2_inst_count
	instance_type = var.aws_ec2_instance_type
	key_name = aws_key_pair.terraform_instance.key_name
	security_groups =[aws_security_group.terra_ins_sec_grp.name] #interpolation
	# ami= var.aws_ec2_ami_id   variable access
	ami=data.aws_ami.aws_ec2_ubuntu_image.id# data block access
	root_block_device { # Storage
		volume_size = var.aws_ec2_root_volume_size # 10 GB
		volume_type = "gp3" # general purpose
	}

	tags= {
		Name = var.aws_ec2_instance_name
	}
}
