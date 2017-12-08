%w(httpd mariadb-server unzip git vim).each do |p|
   package p do 
       action :install
   end
end

execute "epel" do
   not_if "rpm -qa | grep epel"
   command 'rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
end

execute "webtatic" do
   not_if "rpm -qa | grep webtatic"
   command 'rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm'
end

%w(mod_php71w php71w-cli php71w-common php71w-gd php71w-mbstring php71w-mcrypt php71w-mysqlnd php71w-xml).each do |p|
  package p do 
     action :install
  end
end

["httpd","mariadb"].each do |p|
    service p do
       action [:start, :enable]
    end
end
