#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java_se'

#Download tomcat archive
remote_file "/tmp/tomcat8.tar.gz" do
  source node['tomcat']['download_url']
  owner node['tomcat']['tomcat_user']
  mode '0644'
  action :create
end

#create tomcat install dir
directory node['tomcat']['install_location'] do
  owner node['tomcat']['tomcat_user']
  mode '0755'
  action :create
end


#Extract the tomcat archive to the install location
bash 'Extract tomcat archive' do
  user node['tomcat']['tomcat_user']
  cwd node['tomcat']['install_location']
  code <<-EOH
    tar -zxvf /tmp/tomcat8.tar.gz --strip 1
  EOH
  action :run
end


#Install server.xml from template
template "#{node['tomcat']['install_location']}/conf/server.xml" do
  source 'server.xml.erb'
  owner node['tomcat']['tomcat_user']
  mode '0644'
end

#Install init script
template "/etc/init.d/tomcat" do
  source 'tomcat.erb'
  owner 'root'
  mode '0755'
end

#Start and enable tomcat service
#service 'tomcat' do
#  action [:start]
#end
