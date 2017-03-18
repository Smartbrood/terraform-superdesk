variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" { default = "us-east-1" }

variable "key_name" { default = "default" }
variable "public_key_path" { default = "./sshkeys/default.pub" }
variable "key_path" { default = "./sshkeys/default" }

variable "num_instances" { default = 1 }
variable "instance_type" { default = "t2.small" }

