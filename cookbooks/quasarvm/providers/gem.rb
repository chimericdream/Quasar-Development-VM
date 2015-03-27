# encoding: utf-8

action :install do
  pkg_id = new_resource.name
  pkg_id += " --version #{new_resource.version}" if new_resource.version
  execute "install gem package #{new_resource.name}" do
    command "gem install --no-ri --no-rdoc #{pkg_id}"
    not_if "gem list 2> /dev/null | grep '#{new_resource.name} (#{new_resource.version})'"
  end
end

action :uninstall do
  pkg_id = new_resource.name
  pkg_id += " --version #{new_resource.version}" if new_resource.version
  execute "uninstall gem package #{new_resource.name}" do
    command "gem uninstall #{pkg_id}"
    only_if "gem list 2> /dev/null | grep '#{pkg_id}'"
  end
end