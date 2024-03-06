provider "aws" {
  region = var.region 
}

#terraform s3 backend setup 
terraform {
  backend "s3" {
    buucket = "datablock-terra"
    key = "terraform.tfstate"
    region = "ap-south-1" 
  }
}

#datablock for security group 
data "aws_security_group" "server" {
    name = "default"
}

#resource block for server creation 
resource "aws_instance" "datablock_1" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    tags = var.tags
    vpc_security_group_ids = [data.aws_security_group.server]  
}

#variable block calling all values

variable "region" {
    default = "ap-south-1"
    description = "TERRA SCRIPT WHICH TAKES SG FROM DATA BLOCK"
}

variable "ami" {
    default = "ami-03bb6d83c60fc5f7c"
    description = "ami -d from ap-south-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key_name" {
    default = "id_rsa"
}

variable "tags" {
    type = map 
    default = {
        Name = "TERRA-DATA BLOCK SERVER"
        Environment = "staging"
        Owner = "devpats"
    }
}

output "sgids" {
    value = data.aws_security_group.server.id 
}