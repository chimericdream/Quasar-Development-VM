case node['platform_family']
when "rhel", "fedora", "suse"
  include_recipe "yum::epel"
  yum_package "npm" do
    action :install
  end
end

node['npm']['packages'].each do |pkg|
  quasarvm_npm pkg['name'] do
	version pkg['version']
	action :install
  end
end
