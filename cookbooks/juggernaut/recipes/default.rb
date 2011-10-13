#
# Cookbook Name:: juggernaut
# Recipe:: default
#
# Install and start Juggernaut server
#
# IMPORTANT: This has to run AFTER node.js is installed


# I want to get the address of the DB MASTER from /etc/chef/dna.json
# chef_file = '/etc/chef/dna.json'
# chef_config = JSON.parse(File.read(chef_file))
# chef_config['db_host']
# => "ec2-50-18-101-127.us-west-1.compute.amazonaws.com"

pid_file = '/var/run/juggernaut.pid'
chef_file = '/etc/chef/dna.json'
chef_config = JSON.parse(File.read(chef_file))
redis_host = chef_config['db_host']
redis_port = 6379
redis_user = 'brian'
redis_pwd = 'pwd'
#redis_host = 'http://brian:123@ec2-50-18-101-127.us-west-1.compute.amazonaws.com:6379'

if ['app','app_master','solo'].include?(node[:instance_role])
  install_dir     = "/usr/local/bin"

  ey_cloud_report "juggernaut" do
    message "Setting up juggernaut server"
  end

  execute "npm install juggernaut" do
    command "npm install -g juggernaut"
    not_if { FileTest.exists?("#{install_dir}/juggernaut") }
  end

  execute "start juggernaut daemon" do
    command "/sbin/start-stop-daemon --start --background --exec #{install_dir}/juggernaut --chuid root:root"
#    not_if { FileTest.exists?("#{install_dir}/juggernaut") }
  end

# install init.d
  case node[:instance_role]
    when "solo", "app_master"
      template "/etc/init.d/juggernaut" do
        source "juggernaut.init.d.erb"
        owner "root"
        group "root"
        mode 0755
        variables({
          :pid_file => pid_file,
          :redis_host => redis_host,
          :redis_port => redis_port,
          :redis_user => redis_user,
          :redis_pwd => redis_pwd
        })  
      end
  end



  # add to monit
  case node[:instance_role]
    when "solo", "app_master"
      template "/etc/monit.d/juggernaut.monitrc" do
        source "juggernaut.monitrc.erb"
        owner "root"
        group "root"
        mode 0644
        variables({
          :pid_file => pid_file
        })
      end
  end
  
  # this restart also affects daemons (monitrc for notify and delayed_job)
  # reload monit
  case node[:instance_role]
    when "solo", "app_master"
      execute "monit reload" do
        action :run
      end
  end




end

