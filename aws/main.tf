provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

data "aws_ami" "ubuntu-1604" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "terraform-auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_vpc" "terraform" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "terraform" {
  vpc_id = "${aws_vpc.terraform.id}"
}

resource "aws_route" "terraform_internet_access" {
  route_table_id         = "${aws_vpc.terraform.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.terraform.id}"
}

resource "aws_subnet" "terraform-superdesk" {
  vpc_id                  = "${aws_vpc.terraform.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "terraform-allow-ssh-http" {
  name        = "terraform-allow-ssh-http"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.terraform.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "superdesk" {
  ami           = "${data.aws_ami.ubuntu-1604.id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.terraform-auth.id}"

  vpc_security_group_ids = ["${aws_security_group.terraform-allow-ssh-http.id}"]
  subnet_id = "${aws_subnet.terraform-superdesk.id}"

  connection {
    type        = "ssh"
    private_key = "${file("${var.key_path}")}"
    user        = "ubuntu"
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "provision/superdesk.sh"
    destination = "/tmp/superdesk.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/superdesk.sh",
      "/tmp/superdesk.sh"
    ]
  }

  tags {
    Name = "superdesk"
  }
}

output "superdesk_ip" {
   value = "${aws_instance.superdesk.public_ip}"
}
