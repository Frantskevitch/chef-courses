log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/root/chef-repo/.chef/admin.pem'
validation_client_name   'chef-validator'
validation_key           '/root/chef-repo/.chef/chef-validator.pem'
chef_server_url          'https://chef-server/organizations/t8'
syntax_check_cache_path  '/root/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '/root/chef-repo/cookbooks' ]
