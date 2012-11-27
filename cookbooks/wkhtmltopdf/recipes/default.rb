#
# Cookbook Name:: wkhtmltopdf
# Recipe:: default
#
      
if ['solo','app_master'].include?(node[:instance_role])
  wkhtmltopdf_dir = "/usr/local/bin"

  ey_cloud_report "wkhtmltopdf" do
    message "installing wkhtmltopdf"
  end

  # download wkhtmltopdf 
  remote_file "#{wkhtmltopdf_dir}/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2" do
    source "http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2"
    owner 'root'
    group 'root'
    mode 0644
    backup 0
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2") }
  end

  execute "bkunzip wkhtmltopdf" do
    command "cd #{wkhtmltopdf_dir} && bunzip2 wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2 && sync"
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf-0.10.0_rc2-static-amd64.tar") }
  end

  execute "unarchive wkhtmltopdf" do
    command "cd #{wkhtmltopdf_dir} && tar xvf wkhtmltopdf-0.10.0_rc2-static-amd64.tar && sync"
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf-amd64") }
  end

  execute "remove tar file for wkhtmltopdf" do
    command "cd #{wkhtmltopdf_dir} && rm -f wkhtmltopdf-0.10.0_rc2-static-amd64.tar"
    not_if { !FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf-0.10.0_rc2-static-amd64.tar") }
  end

  execute "move wkhtmltopdf" do
    command "cd #{wkhtmltopdf_dir} && mv wkhtmltopdf-amd64 wkhtmltopdf"
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf") }
  end


end