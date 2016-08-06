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
end

template '/var/www/html/index.html' do
    action :create # can be omitted
    source 'templates/index.html.erb' # can be omitted (serch templates directory)
    owner 'apache'
    group 'apache'
    variables(thisis: 'itamae')
end
