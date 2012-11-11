set :application, "roundmen"
set :sys_user, 'ubuntu'
set :user, 'deploy'
ssh_options[:keys] = ["~/.aws/keys.pem"]

set :scm, :git
set :repository, 'git@github.com:mummifyus/roundmen.git'

set :webservers, ['ec2-54-241-107-237.us-west-1.compute.amazonaws.com']
webservers.each { |s| server s, :web, :app } 

set :depoy_to, "/home/#{user}/www/#{application}"


set :ssh_keys, :deploy=>{'paul'=>IO.read(File.expand_path('~/.ssh/id_rsa.pub'))}

##-----------------------------------------------------------------------------------------
# Sys Tasks
##

namespace :sys do
  
  namespace :server do
    task :create do
      system "knife ec2 server create -I ami-bb88acfe --flavor=t1.micro -x ubuntu  --identity-file=~/.aws/keys.pem -G ssh,http --ssh-key=MyKeys -c .chef/knife.rb"
    end
  end
  
  task :bootstrap do
    set :user, sys_user
    roundsman.run_list 'role[base]'
    # roundsman.run_list 'recipe[base]'
  end
  
  
  namespace :install do 
    task :webserver do
      set :user, sys_user
      roundsman.run_list 'role[webserver]'
    end
  end
  
end


namespace :deploy do
  %w{ start stop restart }.each { |t| task t do ; end }
end