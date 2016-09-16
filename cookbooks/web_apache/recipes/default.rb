#
# Cookbook Name:: web_apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
web "install apache" do
  action :install
  provider "web_apache"
end

