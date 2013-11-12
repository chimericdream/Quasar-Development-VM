case node['platform_family']
when "rhel", "fedora", "suse"
  
  include_recipe "yum::epel"
  include_recipe "yum::remi"
  
  
  %w{php54 php54-pecl-apc php54-mysql php54-mbstring php54-ldap php54-intl php54-curl php54-gd gawk php54-xml php54-xmlrpc php54-pear}.each do |a_package|
    package a_package
  end

when "debian"
    apt_repository "php" do
      uri "http://packages.dotdeb.org/"
      distribution "wheezy"
      components ["all"]
      key "http://www.dotdeb.org/dotdeb.gpg"
    end
    include_recipe "apt::default"

    %w{php5 php5-dev php5-mysql php5-apc php5-intl php5-curl php5-gd gawk}.each do |a_package|
      package a_package
    end
end