action :install do
  package "httpd" do
    action :install
  end
end

action :setup do
  end


action :stop do
  service 'httpd' do
    action :stop
  end
end

action :start do
  service 'httpd' do
    action :start
  end
end

action :restart do
  service 'httpd' do
    action :restart
  end
end

action :reload do
  service 'httpd' do
    action :reload
  end
end
