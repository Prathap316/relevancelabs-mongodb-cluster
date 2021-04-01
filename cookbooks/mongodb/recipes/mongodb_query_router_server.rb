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

#specifying settings in mongod.conf file
template '/etc/mongod.conf' do
    source 'router_mongos.conf.erb'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    variables(
        :logpath => Data['logpath'],
        :port => Data['port']['router'],
        :config_replicaname => Data['replicaname']['config'],
        :config_server_repl1 => Data['config_server']['repl1'],
        :config_server_repl2 => Data['config_server']['repl2'],
        :config_port => Data['port']['config']
    )
end

#Starting mongos service
execute 'command to start mongos' do
   command "mongos --config /etc/mongod.conf --logpath /var/log/mongodb/mongod.log"
   action :run
   ignore_failure :quiet
end

#to add shards details
template '/tmp/add_shard.js' do
    source 'add_shard.erb'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    variables(
        :shard1_name => Data['replicaname']['shard1'],
        :shard2_name => Data['replicaname']['shard2'],
        :sharding1_server_repl1 => Data['shard1_server']['repl1'],
        :sharding1_server_repl2 => Data['shard1_server']['repl2'],
        :sharding2_server_repl1 => Data['shard2_server']['repl1'],
        :sharding2_server_repl2 => Data['shard2_server']['repl2'],
        :sharding_port => Data['port']['shard']
    )
end

execute 'command to add shards' do
    command "mongo --port #{Data['port']['router']} /tmp/add_shard.js"
    action :run
    ignore_failure :quiet
end

