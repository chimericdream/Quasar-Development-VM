name             'quasarvm'
maintainer       'Bill Parrott'
maintainer_email 'bill@chimericdream.com'
license          'MIT License'
description      'Installs/Configures a Basic Web Development Server'
version          '0.4.0'

recipe "quasarvm", "Main Configuration"
recipe "quasarvm::apache", "Apache Configuration"
recipe "quasarvm::npm", "Install Node.js and NPM Packages"
recipe "quasarvm::gems", "Install Ruby Gems"

depends 'git'
depends 'apache2'
depends 'mysql'
depends 'php'
depends 'resolver'
depends 'ntp'
depends 'yum'