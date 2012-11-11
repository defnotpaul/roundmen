name "webserver"
description "The base role for systems that serve HTTP traffic"

default_attributes "apache2" => { "listen_ports" => [ "80", "443" ] }
override_attributes "apache2" => { "max_children" => "50" }

run_list 'recipe[apache2]',   
  'recipe[apache2::mod_ssl]',
  'recipe[apache2::mod_rewrite]',
  'recipe[apache2::mod_deflate]',
  'recipe[apache2::mod_headers]'
  
# env_run_lists "prod" => ["recipe[apache2]"], "staging" => ["recipe[apache2::staging]"], "_default" => []