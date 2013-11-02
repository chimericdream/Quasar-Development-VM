actions :install

attribute :name, :name_attribute => true
attribute :version, :default => nil
attribute :path, :default => nil

def initialize(*args)
  super
  @action = :install
end
