apt_repository 'php5-5.6' do
  uri          'ppa:ondrej/php5-5.6'
  distribution node['lsb']['codename']
end

include_recipe "php-fpm"

%w{php5 php5-curl php5-dev php5-gd php5-mcrypt php5-mysql php5-mysqlnd php5-odbc php5-pgsql php5-sqlite php5-sybase php5-tidy php5-xdebug php5-xmlrpc php5-xsl gawk}.each do |a_package|
  package a_package
end

php_fpm_pool "www"