include_recipe "lamp::config"

bash 'configure mariadb' do
    code <<-EOT
      mysqladmin -u root password '#{node['mariadb']['root']['password']}'
      mysql -u root -p"#{node['mariadb']['root']['password']}" -e "UPDATE mysql.user SET Password=PASSWORD('#{node['mariadb']['root']['password']}') WHERE User='root'"
      mysql -u root -p"#{node['mariadb']['root']['password']}" -e "DELETE FROM mysql.user='root' AND Host NOT IN ('localhost','127.0.0.1','::1')" 
      mysql -u root -p"#{node['mariadb']['root']['password']}" -e "DELETE FROM mysql.user=''" 
      mysql -u root -p"#{node['mariadb']['root']['password']}" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
      mysql -u root -p"#{node['mariadb']['root']['password']}" -e "FLUSH PRIVILEGES"
    EOT
end


template '/tmp/codeigniter.sql' do
    source 'codeigniter.sql.erb'
    variables ({
       :database_name			=> node['mariadb']['database']['name'],
       :database_user			=> node['mariadb']['database']['user'],
       :database_password	        => node['mariadb']['database']['password'],
    })
end

execute "configure codeigniter database" do
    command "mysql -u root -p#{node['mariadb']['root']['password']} < /tmp/codeigniter.sql"
end
