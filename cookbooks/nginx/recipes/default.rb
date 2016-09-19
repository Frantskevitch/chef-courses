#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#Install nginx RPM
rpm_package 'nginx' do
  source node['nginx']['download_url']
end

#install Nginx configuration
template "/etc/nginx/conf.d/default.conf" do
  source 'default.conf.erb'
end

#start nginx service
service 'nginx' do
  action [:start]
end


