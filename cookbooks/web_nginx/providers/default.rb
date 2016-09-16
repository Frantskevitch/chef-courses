action :install do
  execute 'nginx_install' do 
    command 'rpm -i http://nginx.org/packages/centos/6/x86_64/RPMS/nginx-1.8.1-1.el6.ngx.x86_64.rpm'
  end
end

action :setup do
  end


action :stop do
  service 'nginx' do
    action :stop
  end
end

action :start do
  service 'nginx' do
    action :start
  end
end

action :restart do
  service 'nginx' do
    action :restart
  end
end

action :reload do
  service 'nginx' do
    action :reload
  end
end
