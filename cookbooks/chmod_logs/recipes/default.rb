#
# Cookbook Name:: fix_nginx_server_names
# Recipe:: default
#

case node[:instance_role]
  when "solo", "app_master", "app"
    node[:applications].each do |app_name,data|
      
      execute "chmod the log files" do
        command "chmod 0666 /var/log/engineyard/apps/#{app_name}/mail*"
        command "chmod 0666 /var/log/engineyard/apps/#{app_name}/delay*"
        command "chmod 0666 /var/log/engineyard/apps/#{app_name}/notif*"
        command "chmod 0666 /var/log/engineyard/apps/#{app_name}/prod*"
      end
      
    end # end node.each

end # case
