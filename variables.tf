// prefix to use to name all resources
variable "resource_prefix"{}

// connection configs
variable "aws_creds"{
    default = "/Users/jordanmiles/.aws/credentials"
}
variable "aws_config"{
    default = "/Users/jordanmiles/.aws/config"
}
variable "aws_profile"{
    default = "personal"
}
variable "region"{
    default = "us-east-1"
}

variable "ec2_ami" {
    default = "ami-0cff7528ff583bf9a"
}

