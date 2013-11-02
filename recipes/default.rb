include_recipe "yum::epel"

include_recipe "git"

include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"

include_recipe "quasarvm::apache"

include_recipe "mysql"
include_recipe "mysql::server"

include_recipe "php"
include_recipe "php::module_mysql"

include_recipe "resolver"
include_recipe "sqlite"

include_recipe "python"

include_recipe "ntp"

include_recipe "quasarvm::npm"
include_recipe "quasarvm::gems"