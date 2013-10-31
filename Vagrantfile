# -*- mode: ruby -*-
# vi: set ft=ruby :

# Basic VM Information
$vm_name          = "quasar-vm"
$vm_cpus          = "1"
$vm_memory        = "512"

# IP Addresses & Ports
$vm_ip_address    = "66.66.66.10"

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"

  config.vm.network :private_network, ip: $vm_ip_address

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", $vm_memory]
    vb.customize ["modifyvm", :id, "--cpus",   $vm_cpus]
  end

  config.omnibus.chef_version = :latest
end