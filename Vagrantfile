# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.network "private_network", type: "dhcp"

  config.vm.define "superdesk" do |superdesk|
    superdesk.vm.box = "ubuntu/xenial64"
    superdesk.vm.network "forwarded_port", guest: 80, host: 80, protocol: "tcp", auto_correct: true
    superdesk.vm.provision :shell, path: "provision/superdesk.sh"
    superdesk.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.name = "superdesk"
      v.linked_clone = true
      end
    end

end
