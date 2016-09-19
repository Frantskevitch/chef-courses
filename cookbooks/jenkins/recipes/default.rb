#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#add jenkins repository and key
yum_repository 'jenkins-ci' do
  baseurl "http://pkg.jenkins-ci.org/redhat"
  gpgkey  "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
end

#install jenkins
package 'jenkins' do
  version nil
end

#add jenkins config
template "/var/lib/jenkins/config.xml" do
  source 'config.xml.erb'
  owner 'jenkins'
  mode '0755'
end

#modify jenkins sysconfig
template "/etc/sysconfig/jenkins" do
  source 'jenkins.erb'
  owner 'root'
  mode '644'
end

#install maven plugin
template "/var/lib/jenkins/hudson.tasks.Maven.xml" do
  source 'hudson.tasks.Maven.xml.erb'
  owner 'jenkins'
  mode '644'
end

#install jenkins jobs
remote_directory '/var/lib/jenkins/jobs' do
  source 'jobs'
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
  action :create 
end

#install jenkins plugins
remote_directory '/var/lib/jenkins/plugins/' do
  source 'plugins'
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
  action :create
end

#start jenkins
service 'jenkins' do
  action [:start]
end


