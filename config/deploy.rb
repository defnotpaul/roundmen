set :application, "roundmen"
set :sys_user, 'ubuntu'
set :user, 'deploy'
ssh_options[:keys] = ["~/.aws/keys.pem"]

set :scm, :git
set :repository, 'git@github.com:mummifyus/roundmen.git'

set :webservers, ['ec2-50-18-135-138.us-west-1.compute.amazonaws.com']
webservers.each { |s| server s, :web, :app } 


set :depoy_to, "/home/#{user}/www/#{application}"

##-----------------------------------------------------------------------------------------
# Sys Tasks
##

namespace :sys do
  
  task :say_hello do
    run "echo 'hello, world'"
  end
  
  task :bootstrap do
    set :user, sys_user
    roundsman.run_list 'recipe[build-essential]'
    roundsman.run_list 'recipe[base]'
  end
  
  namespace :install do 
    task :webserver do
      set :user, sys_user
      roundsman.run_list 'role[webserver]'
    end
    # task :apache do
    #       set :user, sys_user
    #       roundsman.run_list 'recipe[apache2]', 
    #         'recipe[apache2::mod_rewrite]','recipe[apache2::mod_deflate]','recipe[apache2::mod_headers]'
    #     end
    #     
    #     task :php do
    #       set :user, sys_user
    #       sys.install.apache
    #       roundsman.run_list 'recipe[php]',
    #         'recipe[apache2::mod_php5]'
    #     end
  end
  
end


namespace :deploy do
  %w{ start stop restart }.each { |t| task t do ; end }
end