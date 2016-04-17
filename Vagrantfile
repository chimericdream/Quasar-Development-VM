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

# Override any of the above settings for your local environment
if(File.file?("config.local.rb"))
  require_relative 'config.local.rb'
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
    chef.custom_config_path = "Vagrantfile.chef"

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
        :version => '0.12.5'
      },
      :npm => {
        :packages => [
          {
            :name    => "bower",
            :version => "^1.4.1",
          },
          {
            :name    => "grunt",
            :version => "^0.4.5",
          },
          {
            :name    => "grunt-cli",
            :version => "^0.1.13"
          },
          {
            :name    => "gulp",
            :version => "^3.9.0",
          },
          {
            :name    => "jshint",
            :version => "^2.8.0",
          },
          {
            :name    => "less",
            :version => "^2.5.0",
          },
          {
            :name    => "oc",
            :version => "^0.16.9"
          },
          {
            :name    => "strongloop",
            :version => "^4.0.5"
          },
          {
            :name    => "uglify-js",
            :version => "^2.4.23",
          },
          {
            :name    => "yui",
            :version => "^3.18.1",
          },
          {
            :name    => "yuicompressor",
            :version => "^2.4.8",
          }
        ]
      },
      "opscode-ruby" => {
        :versions => ['1.9.3-p551', '2.0.0-p645', '2.1.6', '2.2.4', '2.3.0-dev', 'rbx-2.5.5'],
        :global => '2.2.4'
      },
      :php => {
        :timezone => "America/Chicago",
      },
      :pypip => {
        :pips => [
          {
            :name    => "django",
            :version => "1.8.2",
          },
          {
            :name    => "flup",
            :version => "1.0.2",
          },
          {
            :name    => "pyechonest",
            :version => "9.0.0",
          },
          {
            :name    => "web.py",
            :version => "0.37",
          }
        ]
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
        :gems => [
          {
            :name    => "compass",
            :version => "1.0.3",
          },
          {
            :name    => "htmlentities",
            :version => "4.3.3"
          },
          {
            :name    => "jekyll",
            :version => "2.5.3",
          },
          {
            :name    => "jekyll-import",
            :version => "0.7.1"
          },
          {
            :name    => "jekyll-lunr-js-search",
            :version => "0.3.0"
          },
          {
            :name    => "jekyll-mentions",
            :version => "0.2.1"
          },
          {
            :name    => "jekyll-pandoc",
            :version => "0.0.8"
          },
          {
            :name    => "jekyll-redirect-from",
            :version => "0.8.0"
          },
          {
            :name    => "jekyll-sitemap",
            :version => "0.8.1"
          },
          {
            :name    => "jekyll_figure",
            :version => "0.0.3"
          },
          {
            :name    => "jemoji",
            :version => "0.5.0"
          },
          {
            :name    => "mysql2",
            :version => "0.3.18"
          },
          {
            :name    => "observr",
            :version => "1.0.5",
          },
          {
            :name    => "rubysl-shellwords",
            :version => "2.0.0"
          },
          {
            :name    => "sass",
            :version => "3.4.15",
          },
          {
            :name    => "sequel",
            :version => "4.23.0"
          },
          {
            :name    => "unidecode",
            :version => "1.0.0"
          }
        ]
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
