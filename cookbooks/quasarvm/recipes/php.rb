apt_repository 'php5-5.6' do
  uri          'ppa:ondrej/php5-5.6'
  distribution node['lsb']['codename']
end
include_recipe "apt::default"

%w{php5 php5-curl php5-dev php5-gd php5-mcrypt php5-mysql php5-mysqlnd php5-odbc php5-pgsql php5-sqlite php5-sybase php5-tidy php5-xdebug php5-xmlrpc php5-xsl gawk}.each do |a_package|
  package a_package
end

#apt_repository "php" do
#  uri "http://packages.dotdeb.org/"
#  distribution "wheezy-php56"
#  components ["all"]
#  key "http://www.dotdeb.org/dotdeb.gpg"
#end
#
#%w{php5 php5-dev php5-mysql php5-intl php5-curl php5-gd gawk}.each do |a_package|
#  package a_package
#end

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
end