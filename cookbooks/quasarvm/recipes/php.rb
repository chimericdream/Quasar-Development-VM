apt_repository 'php' do
  uri          'ppa:ondrej/php'
  distribution node['lsb']['codename']
end

%w{php7.0 php7.0-mysql libapache2-mod-php7.0}.each do |a_package|
  package a_package
end