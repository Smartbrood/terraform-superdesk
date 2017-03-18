variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" { default = "us-east-1" }
variable "aws_instance_type" { default = "t2.small" }

variable "digitalocean_api_token" {}
variable "digitalocean_region" { default = "FRA1" }
variable "digitalocean_superdesk_image" { default = "ubuntu-16-04-x64" }
variable "digitalocean_size" { default = "2gb" }

variable "key_name" { default = "default" }
variable "public_key_path" { default = "./sshkeys/default.pub" }
variable "key_path" { default = "./sshkeys/default" }
variable "ssh_key_ID" { default = "4c:f5:cf:43:80:13:a4:3d:1f:4d:9d:b6:07:db:75:87" }

variable "num_instances" { default = 1 }
