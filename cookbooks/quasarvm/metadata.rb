name             'quasarvm'
maintainer       'Bill Parrott'
maintainer_email 'bill@chimericdream.com'
license          'MIT License'
description      'Installs/Configures a Basic Web Development Server'
version          '2.0.0'

recipe "quasarvm", "Main Configuration"
recipe "quasarvm::nginx", "nginx Configuration"
recipe "quasarvm::php", "PHP Configuration"
recipe "quasarvm::npm", "Install Node.js and NPM Packages"
recipe "quasarvm::gems", "Install Ruby Gems"
recipe "quasarvm::python", "Install Python Packages with PIP"

depends 'apt'
depends 'git'
depends 'java'
depends 'nginx'
depends 'mysql'
depends 'php-fpm'
depends 'resolver'
depends 'ntp'
depends 'yum'
depends 'sqlite'
depends 'python'
depends 'nodejs'
depends 'mongodb'
depends 'rbenv'
depends 'phantomjs'
depends 'chrome'
depends 'firefox'
