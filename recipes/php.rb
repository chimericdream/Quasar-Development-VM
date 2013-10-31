template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
end