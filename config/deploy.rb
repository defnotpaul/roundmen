set :application, "roundmen"
set :webservers, ['ec2-50-18-135-138.us-west-1.compute.amazonaws.com']
set :default_user, 'ubuntu'
set :user, 'deploy'

ssh_options[:keys] = ["~/code/chef/mummifyus/chef/keys/MyKeys.pem"]

webservers.each { |s| server s, :web, :app } 

# set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"


namespace :sys do
  
  task :say_hello do
    run "echo 'hello, world'"
  end
  
  task :bootstrap do
    set :user, default_user
    roundsman.run_list 'recipe[build-essential]'
    roundsman.run_list 'recipe[base]'
  end
  
  namespace :install do 
    task :apache do
      set :user, default_user
      roundsman.run_list 'recipe[apache2], recipe[apache2::mod_rewrite], recipe[apache2::mod_deflate], recipe[apache2::mod_headers]'
    end
    
    task :php do
      set :user, default_user
      roundsman.run_list 'recipe[php], recipe[apache2::mod_php5]'
    end
  end
  
end


namespace :deploy do
  %w{ start stop restart }.each { |t| task t do ; end }
end