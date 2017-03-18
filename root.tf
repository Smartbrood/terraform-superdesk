module "aws" {
  source	         = "./aws"
  aws_access_key     = "${var.aws_access_key}"
  aws_secret_key     = "${var.aws_secret_key}"
  region             = "${var.aws_region}"
  instance_type      = "${var.aws_instance_type}"
  num_instances      = "${var.num_instances}"
  key_path           = "${var.key_path}"
  public_key_path    = "${var.public_key_path}"
  key_name           = "${var.key_name}"
}

module "digitalocean" {
  source	          = "./digitalocean"
  api_token           = "${var.digitalocean_api_token}"
  ssh_key_ID          = "${var.ssh_key_ID}"
  key_path            = "${var.key_path}"
  region              = "${var.digitalocean_region}"
  size                = "${var.digitalocean_size}"
  superdesk_image     = "${var.digitalocean_superdesk_image}"
  num_instances       = "${var.num_instances}"
}


output "digitalocean_superdesk_ip" {
      value = "${module.digitalocean.superdesk_ip}"
}

output "aws_public_ip" {
      value = "${module.aws.superdesk_ip}"
}


