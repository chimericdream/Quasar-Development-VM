include_recipe "git"

include_recipe "php"

include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"

include_recipe "quasarvm::apache"

include_recipe "resolver"