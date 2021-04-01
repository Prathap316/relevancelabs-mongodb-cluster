Data = data_bag_item('mongodb_databag', 'dev')

#creating mongodb-org.repo content from template
template '/etc/yum.repos.d/mongodb-org.repo' do
    source 'mongodb-org.repo.erb'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

#Install mongodb-org package
package 'mongodb-org' do
    action :install
end

#Creating data directory that stores metadata
directory "#{Data['dbpath']}" do
    owner 'mongod'
    group 'mongod'
    mode '0755'
    action :create
end

#specifying settings in mongod.conf file
template '/etc/mongod.conf' do
    source 'config_mongod.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables(
        :logpath => Data['logpath'],
        :dbpath => Data['dbpath'],
        :port => Data['port']['config'],
        :replicaname => Data['replicaname']['config']
    )
end

#Restart the mongod service
service 'mongod' do
    action :restart
end

#Initilizing the replica set
template '/tmp/config_initilize_replset.js' do
    source 'config_initilize_replset.js.erb'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    variables(
        :port => Data['port']['config'],
        :replicaname => Data['replicaname']['config'],
        :config_server_repl1 => Data['config_server']['repl1'],
        :config_server_repl2 => Data['config_server']['repl2']
    )
    
end

execute 'command to initilize replica set' do
    command "mongo --port #{Data['port']['config']} /tmp/config_initilize_replset.js"
    action :run
    ignore_failure :quiet
end