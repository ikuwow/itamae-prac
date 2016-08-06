%w{tree git}.each do |pkg|
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


