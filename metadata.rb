name             'quasarvm'
maintainer       'Bill Parrott'
maintainer_email 'bill@chimericdream.com'
license          'MIT License'
description      'Installs/Configures a Basic Web Development Server'
version          '0.1.0'

recipe "quasarvm", "Main Configuration"
recipe "quasarvm::apache", "Apache Configuration"
recipe "quasarvm::php", "PHP Package Configuration"

depends 'git'
depends 'apache2'
depends 'php'
