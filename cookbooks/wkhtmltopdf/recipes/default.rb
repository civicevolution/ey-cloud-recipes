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
    command "curl http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2 | bunzip2 - | tar xvf -"
    command "mv wkhtmltopdf-amd64 wkhtmltopdf"
    not_if { FileTest.exists?("#{wkhtmltopdf_dir}/wkhtmltopdf") }
  end


end