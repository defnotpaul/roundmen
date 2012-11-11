name "base"
description "The base role"

run_list 'recipe[build-essential]',   
  'recipe[base]'  
# env_run_lists "prod" => ["recipe[apache2]"], "staging" => ["recipe[apache2::staging]"], "_default" => []