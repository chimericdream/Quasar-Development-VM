action :install do
  pkg_id = new_resource.name
  pkg_id += "@#{new_resource.version}" if new_resource.version
  execute "install NPM package #{new_resource.name}" do
    command "npm -g install #{pkg_id}"
    not_if "npm ls -g 2> /dev/null | grep '#{pkg_id}'"
  end
end