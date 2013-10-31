# Quasar Web Development VM

The latest install instructions will always be available at https://github.com/chimericdream/Quasar-Development-VM

## Installation

1. Install the latest version of [Vagrant](http://downloads.vagrantup.com/)
2. Install the latest<sup>1</sup> version of [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
3. Install the latest version of Ruby
	* [Windows](http://rubyinstaller.org/downloads/)
	* [Mac/Linux](http://rvm.io/)
4. Clone this repository
	* `git clone git@github.com:chimericdream/Quasar-Development-VM.git ~/vagrant/quasar-vm`
5. Run the setup script
	* `cd ~/vagrant/quasar-vm;sh setup.sh`
	* This script makes sure you have the following items installed:
		* Berkshelf Ruby Gem
		* Vagrant VBGuest Plugin
		* Vagrant Berkshelf Plugin
		* Vagrant Omnibus Plugin
6. Start the VM
	* `cd ~/vagrant/quasar-vm;vagrant up`

## Tested environments

**Windows 8.1 64-bit**

 * VirtualBox 4.2.18
 * Vagrant 1.3.5
 * Ruby 1.9.3p448

### Footnotes
1. There is a known issue with VirtualBox 4.3 that causes it to fail when creating the network interface. Therefore, use version 4.2.18 for the time being. [See here for more information.](https://github.com/mitchellh/vagrant/issues/2392)