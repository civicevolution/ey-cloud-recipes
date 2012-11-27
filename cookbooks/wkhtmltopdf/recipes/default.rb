#
# Cookbook Name:: wkhtmltopdf
# Recipe:: default
#
      
if ['solo','app_master'].include?(node[:instance_role])
  wkhtmltopdf_dir = "/opt/bin"

  ey_cloud_report "wkhtmltopdf" do
    message "installing wkhtmltopdf"
  end

  execute "cd for wkhtmltopdf" do
    command "cd #{wkhtmltopdf_dir}"
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf") }
  end
  
  # download wkhtmltopdf 
  remote_file "wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2" do
    source "http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2"
    owner 'root'
    group 'root'
    mode 0644
    backup 0
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf") }
  end

  execute "unzip wkhtmltopdf" do
    command "bunzip2 wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2 && sync"
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf") }
  end

  execute "unarchive wkhtmltopdf" do
    command "tar xvf wkhtmltopdf-0.10.0_rc2-static-amd64.tar && sync"
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf") }
  end

  execute "cd for wkhtmltopdf" do
    command "mv wkhtmltopdf-amd64 wkhtmltopdf"
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf") }
  end


end