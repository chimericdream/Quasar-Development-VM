# Quasar Web Development VM

The latest install instructions will always be available at https://github.com/chimericdream/Quasar-Development-VM

## Latest Version

The current version of the Quasar VM is 1.0.

## Installation

1. Install the latest version of [Vagrant](http://downloads.vagrantup.com/)
2. Install the latest version of [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
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
	* The script may require admin rights to run, so if it fails, run the script  with `sudo`
6. Start the VM
	* `cd ~/vagrant/quasar-vm;vagrant up`

## Tested environments

**Windows 8.1**

 * VirtualBox 4.2.x
 * Vagrant 1.3.5
 * Ruby 1.9.x

**Mac OS X 10.8+**

 * VirtualBox 4.3.x
 * Vagrant 1.3.x
 * Ruby 1.9.x

**Ubuntu **

 * VirtualBox 4.2.x
 * Vagrant 1.3.x
 * Ruby 1.8.x

## Credits

I could not have gotten much of this VM working without the help of Chris Escalante, a web developer at the University of Kansas. He built and maintains the VM used by our dev team, and many of the features in this VM are based on things I learned from his work.

## Copyright and License

The MIT License (MIT)

Copyright (c) 2013 Bill Parrott

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.