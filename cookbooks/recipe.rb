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
