provider "digitalocean" {
  token = "${var.api_token}"
}

resource "digitalocean_droplet" "superdesk" {
  ssh_keys           = ["${var.ssh_key_ID}"]
  image              = "${var.superdesk_image}"
  region             = "${var.region}"
  size               = "${var.size}"
  name               = "superdesk-${count.index + 1}"
  count              = "${var.num_instances}"

  connection {
    type        = "ssh"
    private_key = "${file("${var.key_path}")}"
    user        = "root"
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
}

output "superdesk_ip" {
   value = "${digitalocean_droplet.superdesk.ipv4_address}"
}
