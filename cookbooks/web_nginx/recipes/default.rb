#
# Cookbook Name:: web_nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
web "install nginx" do
  action :install
  provider "web_nginx"
end

web "setup default page" do
  action :setup
  provider "web_nginx"
end
