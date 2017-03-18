variable "api_token" {}
variable "region" { default = "FRA1" }

variable "superdesk_image" { 
  description = "Superdesk image"
  default = "ubuntu-16-04-x64" # Change to ID from Packer output
}

variable "key_name" { default = "default" }
variable "public_key_path" { default = "./sshkeys/default.pub" }
variable "key_path" { default = "./sshkeys/default" }
variable "ssh_key_ID" { default = "4c:f5:cf:43:80:13:a4:3d:1f:4d:9d:b6:07:db:75:87" }

variable "num_instances" { default = 1 }
variable "size" { default = "2gb" }
