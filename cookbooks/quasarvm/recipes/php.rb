apt_repository 'php' do
  uri          'ppa:ondrej/php'
  distribution node['lsb']['codename']
end

%w{php7.0 php7.0-curl php7.0-dev php7.0-gd php7.0-mcrypt php7.0-mysql php7.0-mysqlnd php7.0-odbc php7.0-pgsql php7.0-sqlite php7.0-sybase php7.0-tidy php7.0-xmlrpc php7.0-xsl gawk libapache2-mod-php7.0 php7.0-bcmath}.each do |a_package|
  package a_package
end

%w{apache2 cli fpm}.each do |folder|
  template "/etc/php/7.0/#{folder}/php.ini" do
    source "php.ini.erb"
    owner "root"
    group "root"
    mode 0644
  end
end
