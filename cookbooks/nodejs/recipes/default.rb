#
# Cookbook Name:: nodejs
# Recipe:: default
#

if ['solo','app_master'].include?(node[:instance_role])
  #http://nodejs.org/dist/v0.6.6/node-v0.6.6.tar.gz
  node_version = "v0.8.14"
  nodejs_file = "node-#{node_version}.tar.gz"
  nodejs_dist_dir = "#{node_version}"
  nodejs_dir = "node-#{node_version}"
  nodejs_url = "http://nodejs.org/dist/#{nodejs_dist_dir}/#{nodejs_file}"
  
  node_dir = "/opt/node"

  ey_cloud_report "nodejs" do
    message "configuring nodejs (#{nodejs_dir})"
  end

  directory "#{node_dir}" do
    owner 'root'
    group 'root'
    mode 0755
    recursive true
  end
  
  # download nodejs 
  remote_file "#{node_dir}/#{nodejs_file}" do
    source "#{nodejs_url}"
    owner 'root'
    group 'root'
    mode 0644
    backup 0
    not_if { FileTest.exists?("#{node_dir}/#{nodejs_file}") }
  end

  execute "unarchive nodejs" do
    command "cd #{node_dir} && tar zxf #{nodejs_file} && sync"
    not_if { FileTest.directory?("#{node_dir}/#{nodejs_dir}") }
  end
  
  # hide old  nodejs
  execute "remove old nodejs" do
    command "mv /usr/bin/node /usr/bin/node-old-EY"
    not_if { FileTest.exists?("/usr/bin/node-old-EY") }
  end
  
  # compile nodejs
  execute "configure nodejs" do
    command "export PYTHON=`which /opt/bin/python2.7` && cd #{node_dir}/#{nodejs_dir} && ./configure"
    not_if { FileTest.exists?("#{node_dir}/#{nodejs_dir}/node") }
  end
  
  execute "build nodejs" do
    command "cd #{node_dir}/#{nodejs_dir} && make"
    not_if { FileTest.exists?("#{node_dir}/#{nodejs_dir}/node") }
  end

  execute "install nodejs" do
    command "cd #{node_dir}/#{nodejs_dir} && make install"
    not_if { FileTest.exists?("/usr/local/bin/node") }
  end
  
  execute "symlink nodejs" do
    # create a sym link to replace the old version
    command "ln -sf /usr/local/bin/node /usr/bin/node"
  end
  
  # install npm
  ey_cloud_report "npm" do
    message "configuring npm"
  end

  # download and install npm
  execute "download and install npm" do
    command "curl http://npmjs.org/install.sh | clean=no sh"
    not_if { FileTest.exists?("/usr/local/bin/npm") || FileTest.exists?("/usr/bin/npm") }
  end

end