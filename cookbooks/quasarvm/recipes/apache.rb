apache_module "cgi" do
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

template "#{node[:apache][:dir]}/sites-available/default" do
  source "default-site.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "apache2"), :delayed
end

apache_site "default" do
  enable true
end