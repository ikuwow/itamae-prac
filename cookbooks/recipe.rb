%w{tree git vim-common}.each do |pkg|
    package pkg do
        action :install
    end
end

%w{httpd}.each do |pkg|
    package pkg
end

service 'httpd' do
    action [:enable, :start]
    subscribes :reload, 'remote_file[/etc/php.ini]' # charactoristic!!
end

template '/var/www/html/index.html' do
    action :create # can be omitted
    source 'templates/index.html.erb' # can be omitted (serch templates directory)
    owner 'apache'
    group 'apache'
    variables(thisis: 'itamae')
end

%w{php php-devel php-mbstring php-gd}.each do |pkg|
    package pkg
end

remote_file '/etc/php.ini' do
    action :create # default
    source 'files/php.ini'
    owner 'root'
    group 'root'
end

remote_file '/var/www/html/index.php' do
    owner 'apache'
    group 'apache'
end
# omitted

execute 'create a file' do
    command 'echo hello > /home/vagrant/hello.txt'
    user 'vagrant'
    action :run
    not_if 'test -e /home/vagrant/hello.txt'
end

file '/home/vagrant/hello.txt' do
    action :edit
    block do |content|
        content.gsub!('hello', 'Hello world')
    end
    only_if 'test -e /home/vagrant/hello.txt'
end

# definition
define :install_start_enable_package do
    package params[:name]
    service params[:name] do
        action [:enable, :start]
    end
end

install_start_enable_package 'postfix'

include_recipe './mariadb.rb'
