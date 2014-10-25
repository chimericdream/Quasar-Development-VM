include_recipe "git"

#include_recipe "apache2"
#include_recipe "apache2::mod_php5"
#include_recipe "apache2::mod_rewrite"

#include_recipe "quasarvm::apache"

include_recipe "php-fpm"

php_fpm_pool "www"

include_recipe "nginx"
include_recipe "nginx::server"

include_recipe "quasarvm::nginx"

include_recipe "mysql::server"

include_recipe "resolver"
include_recipe "sqlite"

include_recipe "python"

include_recipe "ntp"

include_recipe "nodejs"
include_recipe "nodejs::npm"

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

include_recipe "rbenv::rbenv_vars"

rbenv_ruby "Ruby 1.9.3" do
  ruby_version "1.9.3-p545"
  global true
end

include_recipe "quasarvm::npm"
include_recipe "quasarvm::gems"
include_recipe "quasarvm::python"

#include_recipe "quasarvm::php"