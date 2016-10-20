include_recipe "git"

include_recipe "apt"

include_recipe "java"

include_recipe "apache2"
include_recipe "apache2::mod_rewrite"

include_recipe "quasarvm::apache"

include_recipe "quasarvm::php"

include_recipe "mysql::server"

include_recipe "resolver"
include_recipe "sqlite"

include_recipe "python"

include_recipe "ntp"

include_recipe "nodejs"
include_recipe "nodejs::npm"

include_recipe "mongodb::default"

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

include_recipe "rbenv::rbenv_vars"

package "ruby-dev" do
  action :install
end

package "libmysqlclient-dev" do
  action :install
end

package "libpcap-dev" do
  action :install
end

rbenv_ruby "Ruby 2.2.4" do
  ruby_version "2.2.4"
  global true
end

include_recipe "chrome::default"
include_recipe "firefox::default"

include_recipe "quasarvm::npm"
include_recipe "quasarvm::gems"
include_recipe "quasarvm::python"
