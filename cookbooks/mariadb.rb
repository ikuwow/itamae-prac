
package 'mariadb-server'
service 'mariadb.service' do
    action [:enable, :start]
end
