include_recipe "lamp::config"

remote_file  '/tmp/codeigniter_source.zip' do
    source "https://github.com/bcit-ci/CodeIgniter/archive/3.1.6.zip"
end

bash "unzip CodeIgniter" do
    code <<-EOT
       rm -rf /var/www/html/{*,.*}
       unzip /tmp/codeigniter_source.zip -d /tmp/
       mv /tmp/CodeIgniter-*/{*,.*} /var/www/html/
       chown -R apache:apache /var/www/html/
    EOT
end


template '/var/www/html/application/config/database.php' do
   source 'database.php.erb'
   variables({
         :database_name     => node['mariadb']['database']['name'],
         :database_user     => node['mariadb']['database']['user'],
         :database_password => node['mariadb']['database']['password'],
   })
end
