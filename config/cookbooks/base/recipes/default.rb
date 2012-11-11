# require 'chef/shell_out'


user 'deploy' do
  comment 'deployment user'
  uid 1111
  gid 'users'
  home "/home/deploy"
  shell "/bin/zsh"
  password "$1$5NWaHETq$1Y7C4qfr5HUfiTHoQ5.Yq/"
end

# add_keys :conf=>{:group=>'users'}, :name=>'deploy'