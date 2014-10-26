# *.(local|vm).(dev|prd)
nginx_site "local.dev" do
  name "local.dev"
  host '~^(?<domain>[a-zA-Z0-9-]+)\.(local|vm)\.(?<devprd>dev|prd)$'
  root "${domain}_${devprd}/public_html"
  index "index.php index.html index.htm"
  location "try_files $uri $uri/ =404"
  phpfpm true
  template_cookbook "quasarvm"
  action [:delete, :create, :enable]
end

# *.python.(dev|prd)
nginx_site "python.dev" do
  name "python.dev"
  host '~^(?<domain>[a-zA-Z0-9-]+)\.python\.(?<devprd>dev|prd)$'
  root "${domain}_${devprd}/public"
  index "index.php index.html index.htm"
  location "try_files $uri $uri/ =404"
  template_cookbook "quasarvm"
  action [:delete, :create, :enable]
end

# *.sf.(dev|prd)
nginx_site "sf.dev" do
  name "sf.dev"
  host '~^(?<domain>[a-zA-Z0-9-]+)\.sf\.(?<devprd>dev|prd)$'
  root "${domain}_${devprd}/web"
  index "index.php index.html index.htm"
  location "try_files $uri $uri/ =404"
  phpfpm true
  template_cookbook "quasarvm"
  action [:delete, :create, :enable]
end

service "nginx" do
  action [:restart]
end
