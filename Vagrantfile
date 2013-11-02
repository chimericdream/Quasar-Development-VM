# -*- mode: ruby -*-
# vi: set ft=ruby :

# Basic VM Information
$vm_name          = "quasar-vm"
$vm_cpus          = "1"
$vm_memory        = "512"
$vm_sites_path    = "/vagrantshare/www"

# Host Information
$host_os          = "Win"                      # Assume Windows because fewer things (such as NFS) are supported than on *nix
$nfs_supported    = false
$local_sites_path = ENV["HOME"] + "/Sites"

# IP Addresses & Ports
$vm_ip_address    = "66.66.66.10"
$vm_http_port     = 80
$host_http_port   = 8088

$chef_log_level   = :info

# Override any of the above settings for your local environment
if(File.file?("config.local.rb"))
  require_relative 'config.local.rb'
end

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box      = "Berkshelf-CentOS-6.3-x86_64-minimal"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url  = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"

  config.vm.hostname = $vm_name
  config.vm.network :private_network, ip: $vm_ip_address

  # In case the host-only networks fails the box is availale via ssh at 2222, http at 8888 and MySQL at 3306
  config.vm.network :forwarded_port, guest: $vm_http_port,  host: $host_http_port

  # Load the directory containing all the sites
  config.vm.synced_folder $local_sites_path, $vm_sites_path, :nfs => $nfs_supported

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", $vm_memory]
    vb.customize ["modifyvm", :id, "--cpus",   $vm_cpus]
  end

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled    = true

  config.vm.provision :chef_solo do |chef|
    chef.log_level = $chef_log_level

    chef.json.merge!({
      :apache => {
        :sites_path   => $vm_sites_path,
        :server_port  => $vm_http_port,
        :listen_ports => [$vm_http_port, "443"]
      },
      :php => {
        :timezone     => "America/Chicago",
      },
      :resolver => {
        :nameservers  => [ 
		  "208.67.222.222", # OpenDNS
		  "208.67.220.220", # OpenDNS
		  "8.8.8.8",        # Google
		  "8.8.4.4"         # Google
		]
      }
    })

    chef.run_list = [
        "recipe[quasarvm::default]"
    ]
  end
end