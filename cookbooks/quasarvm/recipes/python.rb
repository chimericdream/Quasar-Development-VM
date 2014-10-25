node['pypip']['pips'].each do |pkg|
  python_pip pkg['name'] do
	version pkg['version']
  end
end 