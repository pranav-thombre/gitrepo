provider "aws" {
  region = var.region 
}

resource "aws_instance" "amazonubuntumachine" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  count = var.countt
  security_groups = var.security_group

 tags = {
    Name = var.tags
  }
 }

terraform {
  backend "s3" {
    bucket                  = "motogpterratask"
    key                     = "motogp-project"
    region                  = "ap-south-1"
  }
}

variable "region" {
   default = "ap-south-1"
   description = "DEPLOYMENT IN AWS"
 }
variable "ami" {
    default = "ami-03bb6d83c60fc5f7c"
    description = "SERVER"
 }
variable "instance_type" {
    default = "t2.micro"
    description = "TYPE"
 }
 variable "key_name" {
    default = "id_rsa"
    description = "SAME SG FOR ALL"
 }
 variable "countt" {
    default = "5"
 }
 variable "tags" {
    default = "motogp"
 }

 variable "security_group" {
    default = ["vpc-0a0ab11d5bf0f50db"]
 }