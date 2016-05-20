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

$shared_folders   = Hash.new
$forwarded_ports  = Hash.new

# IP Addresses & Ports
$vm_ip_address    = "66.66.66.10"
$vm_http_port     = '80'
$host_http_port   = '8888'
$vm_mysql_port    = '3306'
$host_mysql_port  = '3306'   # Warning, mysql port configuration using 3306 will interfere with any locally run MySQL server.

# Default Proxy Settings
$http_proxy       = nil
$https_proxy      = nil
$noproxy_hosts    = "localhost,127.0.0.1"
$proxy_enabled    = true

$chef_log_level   = :info
$chef_json_extra  = {}

$node_modules     = Hash.new
$ruby_gems        = Hash.new
$python_pips      = Hash.new

# Override any of the above settings for your local environment
if(File.file?("config.local.rb"))
  require_relative 'config.local.rb'
end

$npm_array         = Array.new
$node_modules.each do |n, v|
  $npm_array.push({
    :name    => "#{n}",
    :version => "#{v}"
  })
end

$ruby_array        = Array.new
$ruby_gems.each do |n, v|
  $ruby_array.push({
    :name    => "#{n}",
    :version => "#{v}"
  })
end

$python_array      = Array.new
$python_pips.each do |n, v|
  $python_array.push({
    :name    => "#{n}",
    :version => "#{v}"
  })
end

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box      = "ubuntu-14.04-amd64-vbox"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url  = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"

  config.vm.hostname = $vm_name
  config.vm.network :private_network, ip: $vm_ip_address

  # In case the host-only networks fails the box is availale via ssh at 2222, http at 8888 and MySQL at 3306
  config.vm.network :forwarded_port, guest: $vm_http_port,  host: $host_http_port,  auto_correct: true
  config.vm.network :forwarded_port, guest: $vm_mysql_port, host: $host_mysql_port, auto_correct: true

  $forwarded_ports.each do |host_port, vm_port|
    config.vm.network :forwarded_port, guest: vm_port, host: host_port, auto_correct: true
  end

  # Load the directory containing all the sites
  if(!$host_os.eql?("Win"))
    config.vm.synced_folder $local_sites_path, $vm_sites_path, :nfs => $nfs_supported

    $shared_folders.each do |host_location, vm_location|
      config.vm.synced_folder host_location, vm_location, :nfs => $nfs_supported
    end
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", $vm_memory]
    vb.customize ["modifyvm", :id, "--cpus",   $vm_cpus]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    if($host_os.eql?("Win"))
      vb.customize ["sharedfolder", "add", :id, "--name", "www", "--hostpath", (("//?/" + $local_sites_path).gsub("/","\\"))]

      $shared_folders.keys.each_with_index do |host_location, idx|
        vb.customize ["sharedfolder", "add", :id, "--name", "shared_#{idx}", "--hostpath", (("//?/" + host_location).gsub("/","\\"))]
      end
    end
  end

  if($host_os.eql?("Win"))
    config.vm.provision :shell, inline: "mkdir -p #{$vm_sites_path}", run: "always"
    config.vm.provision :shell, inline: "mount -t vboxsf -rw -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` www #{$vm_sites_path}", run: "always"

    $shared_folders.values.each_with_index do |vm_location, idx|
      config.vm.provision :shell, inline: "mkdir -p #{vm_location}", run: "always"
      config.vm.provision :shell, inline: "mount -t vboxsf -rw -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` shared_#{idx} #{vm_location}", run: "always"
    end
  end

  config.omnibus.chef_version = '12.2.1'

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = $http_proxy
    config.proxy.https    = $https_proxy
    config.proxy.no_proxy = $noproxy_hosts
    config.proxy.enabled  = $proxy_enabled
  end

  if(File.file?("beforechef.local.sh"))
    config.vm.provision "shell", path: 'beforechef.local.sh'
  end

  config.vm.provision :chef_solo do |chef|
    chef.log_level = $chef_log_level

    chef.json.merge!({
      :apache => {
        :sites_path   => $vm_sites_path,
        :server_port  => $vm_http_port,
        :listen_ports => [$vm_http_port, "443"]
      },
      :java => {
        :install_flavor => "openjdk",
        :jdk_version => 7
      },
      :mysql => {
        :port                   => $vm_mysql_port,
        :bind_address           => $vm_ip_address,
        :server_root_password   => "root",
        :server_debian_password => "root",
        :server_repl_password   => "root",
        :allow_remote_root      => true
      },
      :nodejs => {
        :install_method => 'source',
        :version        => '4.4.3',
        :source         => {
          :url      => "https://nodejs.org/dist/v4.4.3/node-v4.4.3.tar.gz",
          :checksum => "8e67b95721aab7bd721179da2fe5dd97f9acc1306c15c9712ee103bcd6381638"
        }
      },
      :npm => {
        :packages => $npm_array
      },
      "opscode-ruby" => {
        :versions => ['1.9.3-p551', '2.0.0-p645', '2.1.6', '2.2.4', '2.3.0-dev', 'rbx-2.5.5'],
        :global => '2.2.4'
      },
      :php => {
        :timezone => "America/Chicago",
      },
      :pypip => {
        :pips => $python_array
      },
      :rbenv => {
        :user  => "vagrant",
        :group => "vagrant"
      },
      :resolver => {
        :nameservers => [ 
          "208.67.222.222", # OpenDNS
          "208.67.220.220", # OpenDNS
          "8.8.8.8",        # Google
          "8.8.4.4"         # Google
        ]
      },
      :ruby => {
        :gems => $ruby_array
      }
    })

    chef.json.merge!($chef_json_extra)

    chef.run_list = [
      "recipe[quasarvm::default]"
    ]
  end

  if(File.file?("templates/mysql.local.sql"))
    config.vm.provision "shell", inline: "mysql --user=root --password=root < /vagrant/templates/mysql.local.sql"
  end

  if(File.file?("provision.local.sh"))
    config.vm.provision "shell", path: 'provision.local.sh'
  end
end
