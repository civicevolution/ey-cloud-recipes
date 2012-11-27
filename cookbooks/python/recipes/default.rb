#
# Cookbook Name:: python
# Recipe:: default
#
      
if ['solo','app_master'].include?(node[:instance_role])
  python_version = "2.7.3"
  python_file = "Python-#{python_version}"
  python_file_dist = "Python-#{python_version}.tgz"
  python_dist_dir = "#{python_version}"
  python_dir = "/opt/python"
  python_url = "http://www.python.org/ftp/python/#{python_dist_dir}/#{python_file_dist}"

  ey_cloud_report "python" do
    message "configuring python (#{python_dir})"
  end

  directory "#{python_dir}" do
    owner 'root'
    group 'root'
    mode 0755
    recursive true
  end
  
  # download python 
  remote_file "#{python_dir}/#{python_file_dist}" do
    source "#{python_url}"
    owner 'root'
    group 'root'
    mode 0644
    backup 0
    not_if { FileTest.exists?("#{python_dir}/#{python_file_dist}") }
  end

  execute "unarchive python" do
    command "cd #{python_dir} && tar zxf #{python_file_dist} && sync"
    not_if { FileTest.directory?("#{python_dir}/#{python_file}") }
  end
  
  # hide old  python
  execute "remove old python" do
    command "mv /usr/bin/python /usr/bin/python-old-EY"
    not_if { FileTest.exists?("/usr/bin/python-old-EY") }
  end
  
  # compile python
  execute "configure python" do
    command "cd #{python_dir}/#{python_file} && ./configure --prefix=/opt"
    not_if { FileTest.exists?("#{python_dir}/#{python_file}/python") }
  end
  
  execute "build python" do
    command "cd #{python_dir}/#{python_file} && make"
    not_if { FileTest.exists?("#{python_dir}/#{python_file}/python") }
  end

  execute "install python" do
    command "cd #{python_dir}/#{python_file} && make install"
    not_if { FileTest.exists?("/opt/bin/python2.7") }
  end
  
  # Do not override system python as it is needed by EY chef recipes
  # In node use export PYTHON=`which /opt/bin/python2.7`
  #execute "symlink python" do
  #  # create a sym link to replace the old version
  #  command "ln -sf /opt/bin/python2.7 /usr/bin/python"
  #end
  

end