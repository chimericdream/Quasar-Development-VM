template "#{node["nginx"]["dir"]}/cors_config.conf" do
  source "cors_config.conf.erb"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[nginx]"
end

template "#{node["nginx"]["dir"]}/conf.d/site_configs.conf" do
  source "nginx_site_configs.conf.erb"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[nginx]"
end

# *.(local|vm).(dev|prd)
nginx_site "local.dev" do
  name "local.dev"
  host '~^(?<domain>[a-zA-Z0-9][a-zA-Z0-9\.-]*)\.(local|vm)\.(?<devprd>dev|prd)$'
  root "${domain}_${devprd}/public_html"
  index "index.htm index.html index.php"
  location "try_files $uri $uri/ /index.php =404"
  phpfpm true
  template_cookbook "quasarvm"
  action [:delete, :create, :enable]
end

# *.python.(dev|prd)
nginx_site "python.dev" do
  name "python.dev"
  host '~^(?<domain>[a-zA-Z0-9][a-zA-Z0-9\.-]*)\.python\.(?<devprd>dev|prd)$'
  root "${domain}_${devprd}/public"
  index "index.php index.html /index.htm"
  location "try_files $uri $uri/ =404"
  template_cookbook "quasarvm"
  action [:delete, :create, :enable]
end

# *.sf.(dev|prd)
nginx_site "sf.dev" do
  name "sf.dev"
  host '~^(?<domain>[a-zA-Z0-9][a-zA-Z0-9\.-]*)\.sf\.(?<devprd>dev|prd)$'
  root "${domain}_${devprd}/web"
  index "index.php index.html index.htm"
  location "try_files $uri $uri/ /app_dev.php =404"
  phpfpm true
  template_cookbook "quasarvm"
  action [:delete, :create, :enable]
end

service "nginx" do
  action [:restart]
end
