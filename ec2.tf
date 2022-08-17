module "keypair" {
    source = "./modules/keypair"
}

resource "aws_instance" "jmtf_ec2_bastion"{
    ami = var.ec2_ami
    instance_type = "t2.micro"

    subnet_id = aws_subnet.jmtf_public_sub_1.id
    vpc_security_group_ids = [aws_security_group.jmtf_ec2_bastion_sg.id]

    associate_public_ip_address = true

    key_name = module.keypair.bastion_key_name

    tags = {
      "Name" = "${var.resource_prefix}_ec2_bastion"
    }
}

resource "aws_instance" "jmtf_ec2_private"{
    ami = var.ec2_ami
    instance_type = "t2.micro"

    subnet_id = aws_subnet.jmtf_private_sub_1.id
    vpc_security_group_ids = [aws_security_group.jmtf_ec2_private_sg.id]

    key_name = module.keypair.bastion_key_name

    tags = {
      "Name" = "${var.resource_prefix}_ec2_private"
    }
}

resource "aws_security_group" "jmtf_ec2_bastion_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.jmtf_play_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "jmtf_ec2_private_sg" {
  name        = "${var.resource_prefix}_bastion_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.jmtf_play_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [aws_security_group.jmtf_ec2_bastion_sg.id]
  }

  tags = {
    Name = "allow_tls"
  }
}