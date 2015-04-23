apache_module "cgi" do
   enable true
end

apache_module "proxy_fcgi" do
   enable true
end

apache_module "substitute" do
   enable true
end

apache_module "include" do
    enable true
end

apache_module "rewrite" do
    enable true
end

template "#{node[:apache][:dir]}/sites-available/000-default.conf" do
  source "apache_default_site.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "apache2"), :delayed
end

apache_site "default" do
  enable true
end