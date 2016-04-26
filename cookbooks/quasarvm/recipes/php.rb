apt_repository 'php' do
  uri          'ppa:ondrej/php'
  distribution node['lsb']['codename']
end

include_recipe "php-fpm"

%w{php7.0 php7.0-mysql}.each do |a_package|
  package a_package
end

php_fpm_pool "www"