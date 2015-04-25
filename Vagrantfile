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

# IP Addresses & Ports
$vm_ip_address    = "66.66.66.10"
$vm_http_port     = '80'
$host_http_port   = '8088'
$vm_mysql_port    = '3306'
$host_mysql_port  = '3306'   # Warning, mysql port configuration using 3306 will interfere with any locally run MySQL server.

# Default Proxy Settings
$http_proxy       = ""
$https_proxy      = ""
$noproxy_hosts    = "localhost,127.0.0.1"
$proxy_enabled    = true

# Default nginx Settings
$enable_site_configs  = true
$cors_enabled         = true
$cors_allowed_origins = ".*" # Allow requests from any origin. DO NOT LEAVE THIS AS-IS FOR A PRODUCTION SERVER
$cors_allowed_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
$cors_allowed_headers = "Authorization,Content-Length,Content-Type,Accept,Origin,User-Agent,DNT,Cache-Control,X-Mx-ReqToken,Keep-Alive,X-Requested-With,If-Modified-Since"
$nginx_log_level      = "debug" # One of: [debug | info | notice | warn | error | crit | alert | emerg]

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
  config.vm.network :forwarded_port, guest: $vm_http_port,  host: $host_http_port
  config.vm.network :forwarded_port, guest: $vm_mysql_port, host: $host_mysql_port
  config.vm.network :forwarded_port, guest: 3000, host: 3000, auto_correct: true
  config.vm.network :forwarded_port, guest: 3131, host: 3131, auto_correct: true

  # Load the directory containing all the sites
  config.vm.synced_folder $local_sites_path, $vm_sites_path, :nfs => $nfs_supported

  $shared_folders.each do |host_location, vm_location|
    config.vm.synced_folder host_location, vm_location, :nfs => $nfs_supported
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", $vm_memory]
    vb.customize ["modifyvm", :id, "--cpus",   $vm_cpus]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.omnibus.chef_version = '11.16.4'

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
      :phantomjs => {
        :version             => '1.9.8'
      },
      :java => {
        :install_flavor      => "openjdk",
        :jdk_version         => 7
      },
      :nginx => {
        :user                => "vagrant",
        :sites_path          => $vm_sites_path,
        :enable_site_configs => $enable_site_configs,
        :cors                => {
          :enabled => $cors_enabled,
          :origins => $cors_allowed_origins,
          :methods => $cors_allowed_methods,
          :headers => $cors_allowed_headers
        },
        :log_level           => $nginx_log_level,
        :repository          => "ppa",
        :repository_sources  => {
          :ppa => {
            :uri => "http://ppa.launchpad.net/nginx/development/ubuntu" # Required until nginx >= 1.7.5 is the stable version (we're using the "always" parameter on "add_header"
          }
        }
      },
      "php-fpm" => {
        :user => "vagrant",
        :group => "vagrant",
        :package_name => "php5-fpm",
        :skip_repository_install => true
      },
      :mysql => {
        :port                   => $vm_mysql_port,
        :bind_address           => $vm_ip_address,
        :server_root_password   => "root",
        :server_debian_password => "root",
        :server_repl_password   => "root",
        :allow_remote_root      => true
      },
      :resolver => {
        :nameservers => [ 
          "208.67.222.222", # OpenDNS
          "208.67.220.220", # OpenDNS
          "8.8.8.8",        # Google
          "8.8.4.4"         # Google
        ]
      },
      :npm => {
        :packages => [
          {
            :name    => "bower",
            :version => "1.3.12",
          },
          {
            :name    => "less",
            :version => "1.7.5",
          },
          {
            :name    => "recess",
            :version => ">=1.1.9",
          },
          {
            :name    => "uglify-js",
            :version => "2.4.15",
          },
          {
            :name    => "jshint",
            :version => "2.5.6",
          },
          {
            :name    => "yui",
            :version => "3.18.1",
          },
          {
            :name    => "yuicompressor",
            :version => "2.4.8",
          },
          {
            :name    => "grunt",
            :version => "0.4.5",
          },
          {
            :name    => "grunt-cli",
            :version => "0.1.13"
          },
          {
            :name    => "gulp",
            :version => "3.8.9",
          }
        ]
      },
      :ruby => {
        :gems => [
          {
            :name    => "sass",
            :version => "3.4.6",
          },
          {
            :name    => "compass",
            :version => "1.0.1",
          },
          {
            :name    => "observr",
            :version => "1.0.5",
          },
          {
            :name    => "rev",
            :version => "0.3.2",
          },
          {
            :name    => "jekyll",
            :version => "2.4.0",
          }
        ]
      },
      :pypip => {
        :pips => [
          {
            :name    => "django",
            :version => "1.7.1",
          },
          {
            :name    => "pyechonest",
            :version => "8.0.2",
          },
          {
            :name    => "web.py",
            :version => "0.37",
          },
          {
            :name    => "flup",
            :version => "1.0.2",
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
