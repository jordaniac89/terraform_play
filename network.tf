
resource "aws_vpc" "jmtf_play_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "jmtf_gw"{
    vpc_id = aws_vpc.jmtf_play_vpc.id
    tags = {
      "Name" = "${var.resource_prefix}_gw"
    }
}

resource "aws_subnet" "jmtf_private_sub_1" {
    vpc_id = aws_vpc.jmtf_play_vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      "Name" = "${var.resource_prefix}_prs1"
    }
}
resource "aws_subnet" "jmtf_private_sub_2" {
    vpc_id = aws_vpc.jmtf_play_vpc.id
    cidr_block = "10.0.2.0/24"
     tags = {
      "Name" = "${var.resource_prefix}_prs2"
    }
}
resource "aws_subnet" "jmtf_public_sub_1" {
    vpc_id = aws_vpc.jmtf_play_vpc.id
    cidr_block = "10.0.3.0/24"
    tags = {
      "Name" = "${var.resource_prefix}_pus1"
    }
}
resource "aws_subnet" "jmtf_public_sub_2" {
    vpc_id = aws_vpc.jmtf_play_vpc.id
    cidr_block = "10.0.4.0/24"
    tags = {
      "Name" = "${var.resource_prefix}_pus2"
    }
}

resource "aws_route_table" "jmtf_private_rt"{
    vpc_id = aws_vpc.jmtf_play_vpc.id
    tags = {
      "Name" = "${var.resource_prefix}_prrt"
    }
}

resource "aws_route_table" "jmtf_public_rt"{
    vpc_id = aws_vpc.jmtf_play_vpc.id
    route {
        cidr_block="0.0.0.0/0"
        gateway_id = aws_internet_gateway.jmtf_gw.id
    }
    tags = {
      "Name" = "${var.resource_prefix}_purt"
      "Type" = "testtag" 
    }
}

resource "aws_route_table_association" "jmtf_public1_rt_assn" {
  subnet_id      = aws_subnet.jmtf_public_sub_1.id
  route_table_id = aws_route_table.jmtf_public_rt.id
}

resource "aws_route_table_association" "jmtf_public2_rt_assn" {
  subnet_id      = aws_subnet.jmtf_public_sub_2.id
  route_table_id = aws_route_table.jmtf_public_rt.id
}