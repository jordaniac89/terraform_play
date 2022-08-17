resource "tls_private_key" "jmtf_bastion_ssh" {
  algorithm = var.key_alg
}

resource "aws_key_pair" "bastion_key" {
  key_name   = var.keyname
  public_key=tls_private_key.jmtf_bastion_ssh.public_key_openssh
}

resource "local_file" "bastion_private_key" {
  content=tls_private_key.jmtf_bastion_ssh.private_key_openssh
  filename = var.private_key_path
}

resource "local_file" "bastion_public_key" {
  content=tls_private_key.jmtf_bastion_ssh.public_key_openssh
  filename = var.public_key_path
}

output "bastion_key_name" {
  value=aws_key_pair.bastion_key.key_name
}