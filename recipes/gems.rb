case node['platform_family']
when "rhel", "fedora", "suse"
  include_recipe "yum::epel"
  %w{rubygems ruby-devel}.each do |a_package|
    package a_package
  end
end

node['ruby']['gems'].each do |gem|
  quasarvm_gem gem['name'] do
	version gem['version']
	action :install
  end
end