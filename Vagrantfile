# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "4096"
  end

  # DNS Server Configuration
  config.vm.define "dns_server" do |dns|
    dns.vm.box = "ubuntu/focal64"
    dns.vm.hostname = "dns.m2.dawan"
    dns.vm.network "private_network", ip: "192.168.33.20"
    dns.vm.provision "shell", path: "prov/dns_server.sh"
  end

  # PKI Server Configuration
  config.vm.define "pki_server" do |pki|
    pki.vm.box = "ubuntu/focal64"
    pki.vm.hostname = "pki.m2.dawan"
    pki.vm.network "private_network", ip: "192.168.33.21"
    pki.vm.provision "shell", path: "prov/pki_server.sh"
  end

  # Apache2 Web Server Configuration
  config.vm.define "web_server" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = "web.m2.dawan"
    web.vm.network "private_network", ip: "192.168.33.22"
    web.vm.provision "shell", path: "prov/web_server.sh"
  end
end
