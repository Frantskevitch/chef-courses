#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt'
include_recipe 'java'
user node['jboss7']['jboss_user'] do
  comment 'jboss User'
  home node['jboss7']['jboss_home']
  system true
  shell '/bin/false'
end


execute 'jboss' do
    command 'yum install -y unzip'
    cwd '/tmp'
    command "wget #{node['jboss7']['dl_url']}"
    command 'unzip jboss-as-7.1.1.Final.zip -d /opt'
    
    not_if { File.directory?('/opt/jboss-as-7.1.1.Final') }  
end


template "#{node['jboss7']['jboss_home']}/standalone/configuration/standalone.xml" do
  source "standalone_xml.erb"
  owner node['jboss7']['jboss_user']
  group node['jboss7']['jboss_group']
  mode '0644'
  notifies :restart, 'service[jboss7]', :delayed
end

template "#{node['jboss7']['jboss_home']}/bin/standalone.conf" do
  source 'standalone_conf.erb'
  owner node['jboss7']['jboss_user']
  group node['jboss7']['jboss_group']
  mode '0644'
  notifies :restart, 'service[jboss7]', :delayed
end

dist_dir, _conf_dir = value_for_platform_family(
  ['debian'] => %w( debian default ),
  ['rhel'] => %w( redhat sysconfig )
)

template '/etc/jboss-as.conf' do
  source "jboss-as.conf.erb"
  mode 0775
  owner 'root'
  group node['root_group']
  only_if { platform_family?('rhel') }
  notifies :restart, 'service[jboss7]', :delayed
end

template '/etc/init.d/jboss7' do
  source "jboss7-init.erb"
  mode 0775
  owner 'root'
  group node['root_group']
  notifies :enable, 'service[jboss7]', :delayed
  notifies :restart, 'service[jboss7]', :delayed
end

remote_file '/tmp/app.zip' do
  source node['jboss7']['download_app'] 
  owner 'jboss'
  group 'jboss'
  mode '0755'
  action :create
  notifies :restart, 'service[jboss7]', :delayed
  
  not_if { File.directory?('/tmp/app.zip') }
end

execute 'app_install' do
    cwd '/tmp'
    command 'unzip -jo app.zip -d /opt/jboss-as-7.1.1.Final/standalone/deployments/'


    not_if { File.directory?('/opt/jboss-as-7.1.1.Final/standalone/deployments/testweb.war') }
end


service 'jboss7' do
  supports restart: true
  action :enable
end








