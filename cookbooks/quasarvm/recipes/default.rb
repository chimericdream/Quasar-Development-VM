include_recipe "git"

include_recipe "apt"

include_recipe "java"

apt_repository 'php5-5.6' do
  uri          'ppa:ondrej/php5-5.6'
  distribution node['lsb']['codename']
end

include_recipe "php-fpm"

%w{php5 php5-curl php5-dev php5-gd php5-mcrypt php5-mysql php5-mysqlnd php5-odbc php5-pgsql php5-sqlite php5-sybase php5-tidy php5-xdebug php5-xmlrpc php5-xsl gawk}.each do |a_package|
  package a_package
end

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

include_recipe "mongodb::default"

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

include_recipe "rbenv::rbenv_vars"

rbenv_ruby "Ruby 1.9.3" do
  ruby_version "1.9.3-p545"
  global true
end

include_recipe "phantomjs::default"
include_recipe "chrome::default"
include_recipe "firefox::default"

include_recipe "quasarvm::npm"
include_recipe "quasarvm::gems"
include_recipe "quasarvm::python"