%w{cgi substitute include rewrite headers proxy proxy_fcgi}.each do |a_mod|
  apache_module a_mod do
    enable true
  end
end

template "#{node[:apache][:dir]}/sites-available/quasar.conf" do
  source "default-site.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "apache2"), :delayed
end

apache_site "quasar" do
  enable true
end